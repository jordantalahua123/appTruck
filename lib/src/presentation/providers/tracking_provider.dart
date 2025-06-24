import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../../domain/models/trip_route.dart';
import '../../domain/models/route_point.dart';
import '../../domain/services/location_service.dart';
import '../../domain/services/route_service.dart';
import '../../data/database/app_database.dart';

class TrackingProvider with ChangeNotifier {
  final LocationService _locationService;
  final RouteService _routeService;
  final AppDatabase _database;
  
  StreamSubscription<LatLng>? _locationSubscription;
  TripRoute? _activeRoute;
  List<LatLng> _currentTrack = [];
  bool _isTracking = false;
  DateTime? _startTime;
  int _elapsedSeconds = 0;
  Timer? _timer;

  TrackingProvider({
    required LocationService locationService,
    required RouteService routeService,
    required AppDatabase database,
  })  : _locationService = locationService,
        _routeService = routeService,
        _database = database;

  // Getters
  bool get isTracking => _isTracking;
  List<LatLng> get currentTrack => List.unmodifiable(_currentTrack);
  TripRoute? get activeRoute => _activeRoute;
  int get elapsedSeconds => _elapsedSeconds;
  String get formattedElapsedTime {
    final hours = _elapsedSeconds ~/ 3600;
    final minutes = (_elapsedSeconds % 3600) ~/ 60;
    final seconds = _elapsedSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<bool> startTracking(TripRoute route) async {
    if (_isTracking) return false;

    final hasPermission = await _locationService.checkPermissions();
    if (!hasPermission) return false;

    _activeRoute = route;
    _isTracking = true;
    _startTime = DateTime.now();
    _currentTrack.clear();

    // Actualizar estado en la base de datos
    await _database.updateRouteStatus(
      routeId: route.id,
      state: TripState.inProgress.toString(),
    );
    
    // Iniciar timer para el tiempo transcurrido
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_startTime != null) {
        _elapsedSeconds = DateTime.now().difference(_startTime!).inSeconds;
        notifyListeners();
      }
    });

    // Suscribirse a actualizaciones de ubicación
    final locationStream = _locationService.startTracking();
    _locationSubscription = locationStream.listen((location) async {
      _currentTrack.add(location);
      
      // Guardar ubicación en la base de datos local
      await _database.saveLocationUpdate(
        latitude: location.latitude,
        longitude: location.longitude,
        routeId: route.id,
      );
      
      await _checkRouteProgress(location);
      notifyListeners();
    });

    notifyListeners();
    return true;
  }

  Future<void> loadActiveRoute() async {
    final routes = await _database.getActiveRoute();
    if (routes.isNotEmpty) {
      final routeData = routes.first;
      final points = await _database.getRoutePoints(routeData['id']);
      
      _activeRoute = TripRoute(
        id: routeData['id'],
        name: routeData['name'],
        points: points.map((p) => RoutePoint(
          id: p['id'],
          name: p['name'],
          latitude: p['latitude'],
          longitude: p['longitude'],
          estimatedArrival: DateTime.fromMillisecondsSinceEpoch(p['estimated_arrival']),
          actualArrival: p['actual_arrival'] != null 
              ? DateTime.fromMillisecondsSinceEpoch(p['actual_arrival'])
              : null,
          isCompleted: p['is_completed'] == 1,
          notes: p['notes'],
        )).toList(),
        createdAt: DateTime.fromMillisecondsSinceEpoch(routeData['created_at']),
        estimatedDurationMinutes: routeData['estimated_duration_minutes'],
        totalDistanceKm: routeData['total_distance_km'],
        state: TripState.values.firstWhere(
          (s) => s.toString() == routeData['state'],
        ),
        startedAt: routeData['started_at'] != null 
            ? DateTime.fromMillisecondsSinceEpoch(routeData['started_at'])
            : null,
        completedAt: routeData['completed_at'] != null 
            ? DateTime.fromMillisecondsSinceEpoch(routeData['completed_at'])
            : null,
        notes: routeData['notes'],
      );
      
      notifyListeners();
    }
  }

  void stopTracking() async {
    _isTracking = false;
    _locationService.stopTracking();
    _locationSubscription?.cancel();
    _timer?.cancel();
    _startTime = null;

    if (_activeRoute != null) {
      await _database.updateRouteStatus(
        routeId: _activeRoute!.id,
        state: TripState.completed.toString(),
      );
    }

    notifyListeners();
  }

  void pauseTracking() async {
    if (!_isTracking) return;
    _locationService.stopTracking();
    _locationSubscription?.cancel();
    _timer?.cancel();

    if (_activeRoute != null) {
      await _database.updateRouteStatus(
        routeId: _activeRoute!.id,
        state: TripState.paused.toString(),
      );
    }

    notifyListeners();
  }

  void resumeTracking() {
    if (!_isTracking) return;
    final locationStream = _locationService.startTracking();
    _locationSubscription = locationStream.listen((location) async {
      _currentTrack.add(location);
      
      if (_activeRoute != null) {
        await _database.saveLocationUpdate(
          latitude: location.latitude,
          longitude: location.longitude,
          routeId: _activeRoute!.id,
        );
      }
      
      await _checkRouteProgress(location);
      notifyListeners();
    });
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_startTime != null) {
        _elapsedSeconds = DateTime.now().difference(_startTime!).inSeconds;
        notifyListeners();
      }
    });

    if (_activeRoute != null) {
      _database.updateRouteStatus(
        routeId: _activeRoute!.id,
        state: TripState.inProgress.toString(),
      );
    }
  }

  Future<void> _checkRouteProgress(LatLng currentLocation) async {
    if (_activeRoute == null || _activeRoute!.points.isEmpty) return;

    // Verificar distancia al siguiente punto
    final nextPoint = _activeRoute!.points.firstWhere(
      (point) => !point.isCompleted,
      orElse: () => _activeRoute!.points.last,
    );

    final distance = const Distance().distance(
      LatLng(currentLocation.latitude, currentLocation.longitude),
      LatLng(nextPoint.latitude, nextPoint.longitude),
    );

    // Si estamos a menos de 50 metros, marcamos el punto como completado
    if (distance < 50 && !nextPoint.isCompleted) {
      await _database.updateRoutePointStatus(
        pointId: nextPoint.id,
        isCompleted: true,
        actualArrival: DateTime.now(),
      );
      
      // Actualizar el punto en memoria
      final index = _activeRoute!.points.indexOf(nextPoint);
      _activeRoute!.points[index] = nextPoint.copyWith(
        isCompleted: true,
        actualArrival: DateTime.now(),
      );
      
      notifyListeners();
    }
  }

  @override
  void dispose() {
    stopTracking();
    super.dispose();
  }
} 