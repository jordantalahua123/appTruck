import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get appName => dotenv.env['APP_NAME'] ?? 'App';
  static String get osrmBaseUrl => dotenv.env['OSRM_BASE_URL'] ?? 'https://router.project-osrm.org/route/v1/driving/';
  
  // Configuración de tiempos
  static int get defaultTimeoutMarginMinutes => int.parse(dotenv.env['DEFAULT_TIMEOUT_MARGIN_MINUTES'] ?? '15');
  static int get gpsUpdateIntervalSeconds => int.parse(dotenv.env['GPS_UPDATE_INTERVAL_SECONDS'] ?? '5');
  
  // Configuración del mapa
  static double get initialMapZoom => double.parse(dotenv.env['INITIAL_MAP_ZOOM'] ?? '10.0');
  static double get defaultLatitude => double.parse(dotenv.env['DEFAULT_LATITUDE'] ?? '0.0');
  static double get defaultLongitude => double.parse(dotenv.env['DEFAULT_LONGITUDE'] ?? '0.0');
  
  // Configuración de la base de datos
  static String get databaseName => dotenv.env['DATABASE_NAME'] ?? 'app.db';
  static int get databaseVersion => int.parse(dotenv.env['DATABASE_VERSION'] ?? '1');
  
  // URL del servidor de sockets
  static String get socketUrl => dotenv.env['SOCKET_URL'] ?? 'http://localhost:3000';
} 