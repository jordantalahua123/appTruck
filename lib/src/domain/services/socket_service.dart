import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;
  final String serverUrl;
  final Function(Map<String, dynamic>) onRouteAssigned;
  final Function(Map<String, dynamic>) onRouteUpdated;
  final Function(String) onRouteDeleted;

  SocketService({
    required this.serverUrl,
    required this.onRouteAssigned,
    required this.onRouteUpdated,
    required this.onRouteDeleted,
  }) {
    _initSocket();
  }

  void _initSocket() {
    socket = IO.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      'reconnection': true,
      'reconnectionDelay': 1000,
      'reconnectionDelayMax': 5000,
      'reconnectionAttempts': 5
    });

    // Configurar listeners
    socket.on('connect', (_) => print('Conectado al servidor de sockets'));
    socket.on('disconnect', (_) => print('Desconectado del servidor de sockets'));

    // Eventos específicos para rutas
    socket.on('route:assigned', (data) => onRouteAssigned(data));
    socket.on('route:updated', (data) => onRouteUpdated(data));
    socket.on('route:deleted', (routeId) => onRouteDeleted(routeId));

    // Conectar al servidor
    socket.connect();
  }

  void connectAsDriver(String driverId) {
    if (!socket.connected) socket.connect();
    socket.emit('driver:connect', {'driverId': driverId});
  }

  void disconnectDriver(String driverId) {
    socket.emit('driver:disconnect', {'driverId': driverId});
    socket.disconnect();
  }

  void updateDriverLocation(String driverId, double lat, double lng) {
    socket.emit('driver:location', {
      'driverId': driverId,
      'location': {
        'lat': lat,
        'lng': lng,
      }
    });
  }

  void updateRouteStatus(String routeId, String status) {
    socket.emit('route:status', {
      'routeId': routeId,
      'status': status,
    });
  }

  Future<void> requestAssignedRoutes(String driverId) async {
    if (!socket.connected) socket.connect();
    socket.emit('driver:request_routes', {'driverId': driverId});
  }

  void dispose() {
    socket.disconnect();
    socket.dispose();
  }
} 