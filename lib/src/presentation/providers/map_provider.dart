import 'package:flutter/foundation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../core/config/app_config.dart';
import '../../domain/models/route_point.dart';
import '../../domain/models/trip_route.dart';

class MapProvider with ChangeNotifier {
  final MapController mapController = MapController();
  LatLng _center = LatLng(
    AppConfig.defaultLatitude,
    AppConfig.defaultLongitude,
  );
  double _zoom = AppConfig.initialMapZoom;
  TripRoute? _activeRoute;
  List<RoutePoint> _selectedPoints = [];
  bool _isRoutePlanning = false;

  // Getters
  LatLng get center => _center;
  double get zoom => _zoom;
  TripRoute? get activeRoute => _activeRoute;
  List<RoutePoint> get selectedPoints => _selectedPoints;
  bool get isRoutePlanning => _isRoutePlanning;

  // Setters con notificación
  void setCenter(LatLng newCenter) {
    _center = newCenter;
    mapController.move(newCenter, _zoom);
    notifyListeners();
  }

  void setZoom(double newZoom) {
    _zoom = newZoom;
    mapController.move(_center, newZoom);
    notifyListeners();
  }

  void setActiveRoute(TripRoute? route) {
    _activeRoute = route;
    if (route != null && route.points.isNotEmpty) {
      final newCenter = LatLng(
        route.points.first.latitude,
        route.points.first.longitude,
      );
      _center = newCenter;
      mapController.move(newCenter, _zoom);
    }
    notifyListeners();
  }

  void toggleRoutePlanning() {
    _isRoutePlanning = !_isRoutePlanning;
    if (!_isRoutePlanning) {
      _selectedPoints.clear();
    }
    notifyListeners();
  }

  void addSelectedPoint(RoutePoint point) {
    _selectedPoints.add(point);
    notifyListeners();
  }

  void removeSelectedPoint(RoutePoint point) {
    _selectedPoints.removeWhere((p) => p.id == point.id);
    notifyListeners();
  }

  void clearSelectedPoints() {
    _selectedPoints.clear();
    notifyListeners();
  }
} 