class AppConfig {
  static const String appName = 'InDrive Clone';
  static const String osrmBaseUrl = 'https://router.project-osrm.org/route/v1/driving/';
  
  // Configuración de tiempos
  static const int defaultTimeoutMarginMinutes = 30;
  static const int gpsUpdateIntervalSeconds = 10;
  
  // Configuración del mapa
  static const double initialMapZoom = 13.0;
  static const double defaultLatitude = -2.1709979; // Guayaquil
  static const double defaultLongitude = -79.9223592;
  
  // Configuración de la base de datos
  static const String databaseName = 'indrive_clone.db';
  static const int databaseVersion = 1;
  
  // URL del servidor de sockets en Vercel
  static const String socketUrl = 'https://backend-socket-one.vercel.app';
} 