import 'package:flutter/foundation.dart';
import '../../domain/models/driver.dart';
import '../../domain/models/trip_route.dart';
import '../../domain/services/socket_service.dart';
import '../../core/config/app_config.dart';

class DriverProvider with ChangeNotifier {
  Driver? _currentDriver;
  TripRoute? _assignedRoute;
  List<Driver> _availableDrivers = [];
  late SocketService _socketService;
  bool _isConnected = false;

  // Getters
  Driver? get currentDriver => _currentDriver;
  TripRoute? get assignedRoute => _assignedRoute;
  List<Driver> get availableDrivers => List.unmodifiable(_availableDrivers);
  bool get hasAssignedRoute => _assignedRoute != null;
  bool get isConnected => _isConnected;

  DriverProvider() {
    _initSocketService();
  }

  void _initSocketService() {
    _socketService = SocketService(
      serverUrl: AppConfig.socketUrl,
      onRouteAssigned: _handleRouteAssigned,
      onRouteUpdated: _handleRouteUpdated,
      onRouteDeleted: _handleRouteDeleted,
    );
  }

  // Para propósitos de demostración, agregamos algunos conductores de ejemplo
  void loadDrivers() {
    _availableDrivers = [
      Driver(
        id: '1',
        name: 'Juan Pérez',
        phoneNumber: '0991234567',
      ),
      Driver(
        id: '2',
        name: 'María López',
        phoneNumber: '0997654321',
      ),
      Driver(
        id: '3',
        name: 'Carlos Ruiz',
        phoneNumber: '0993456789',
      ),
    ];
    notifyListeners();
  }

  void setCurrentDriver(Driver driver) {
    _currentDriver = driver;
    // Conectar al socket cuando se selecciona un conductor
    _socketService.connectAsDriver(driver.id);
    _isConnected = true;
    notifyListeners();
  }

  void _handleRouteAssigned(Map<String, dynamic> data) {
    if (_currentDriver == null) return;

    final route = TripRoute.fromJson(data);
    if (route.driverId == _currentDriver!.id) {
      _assignedRoute = route;
      // Actualizar el conductor con la nueva ruta
      final index = _availableDrivers.indexWhere((d) => d.id == _currentDriver!.id);
      if (index != -1) {
        _availableDrivers[index] = _currentDriver!.copyWith(currentRouteId: route.id);
        _currentDriver = _availableDrivers[index];
      }
      notifyListeners();
    }
  }

  void _handleRouteUpdated(Map<String, dynamic> data) {
    if (_currentDriver == null || _assignedRoute == null) return;

    final updatedRoute = TripRoute.fromJson(data);
    if (updatedRoute.id == _assignedRoute!.id) {
      _assignedRoute = updatedRoute;
      notifyListeners();
    }
  }

  void _handleRouteDeleted(String routeId) {
    if (_currentDriver == null || _assignedRoute == null) return;

    if (routeId == _assignedRoute!.id) {
      completeRoute(_currentDriver!.id);
    }
  }

  void updateLocation(double lat, double lng) {
    if (_currentDriver == null) return;
    _socketService.updateDriverLocation(_currentDriver!.id, lat, lng);
  }

  void completeRoute(String driverId) {
    final driver = _availableDrivers.firstWhere((d) => d.id == driverId);
    final index = _availableDrivers.indexOf(driver);
    _availableDrivers[index] = driver.copyWith(currentRouteId: null);

    if (_currentDriver?.id == driverId) {
      _currentDriver = _availableDrivers[index];
      if (_assignedRoute != null) {
        _socketService.updateRouteStatus(_assignedRoute!.id, 'completed');
      }
      _assignedRoute = null;
    }

    notifyListeners();
  }

  void disconnect() {
    if (_currentDriver != null) {
      _socketService.disconnectDriver(_currentDriver!.id);
      _isConnected = false;
      notifyListeners();
    }
  }

  Future<void> checkForAssignedRoute() async {
    if (_currentDriver == null) return;
    
    try {
      // Solicitar al socket que verifique rutas asignadas
      await _socketService.requestAssignedRoutes(_currentDriver!.id);
      // La respuesta se manejará en _handleRouteAssigned
    } catch (e) {
      debugPrint('Error al verificar rutas asignadas: $e');
    }
  }

  @override
  void dispose() {
    _socketService.dispose();
    super.dispose();
  }
} 