import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../core/config/app_config.dart';

class AppDatabase {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppConfig.databaseName);

    return await openDatabase(
      path,
      version: AppConfig.databaseVersion,
      onCreate: (db, version) async {
        // Tabla para almacenar las ubicaciones cuando estamos offline
        await db.execute('''
          CREATE TABLE location_updates (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            latitude REAL NOT NULL,
            longitude REAL NOT NULL,
            timestamp INTEGER NOT NULL,
            route_id TEXT NOT NULL,
            is_synced INTEGER DEFAULT 0,
            created_at INTEGER DEFAULT (strftime('%s', 'now'))
          )
        ''');

        // Tabla para almacenar las rutas asignadas
        await db.execute('''
          CREATE TABLE routes (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            created_at INTEGER NOT NULL,
            estimated_duration_minutes INTEGER NOT NULL,
            total_distance_km REAL NOT NULL,
            state TEXT NOT NULL,
            started_at INTEGER,
            completed_at INTEGER,
            notes TEXT,
            is_synced INTEGER DEFAULT 0
          )
        ''');

        // Tabla para los puntos de ruta
        await db.execute('''
          CREATE TABLE route_points (
            id TEXT PRIMARY KEY,
            route_id TEXT NOT NULL,
            name TEXT NOT NULL,
            latitude REAL NOT NULL,
            longitude REAL NOT NULL,
            estimated_arrival INTEGER NOT NULL,
            actual_arrival INTEGER,
            is_completed INTEGER DEFAULT 0,
            notes TEXT,
            is_synced INTEGER DEFAULT 0,
            FOREIGN KEY (route_id) REFERENCES routes (id)
          )
        ''');
      },
    );
  }

  // Métodos para manejar ubicaciones offline
  Future<void> saveLocationUpdate({
    required double latitude,
    required double longitude,
    required String routeId,
  }) async {
    final db = await database;
    await db.insert('location_updates', {
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'route_id': routeId,
      'is_synced': 0,
    });
  }

  Future<List<Map<String, dynamic>>> getPendingLocationUpdates() async {
    final db = await database;
    return await db.query(
      'location_updates',
      where: 'is_synced = 0',
      orderBy: 'timestamp ASC',
    );
  }

  Future<void> markLocationsAsSynced(List<int> ids) async {
    final db = await database;
    await db.update(
      'location_updates',
      {'is_synced': 1},
      where: 'id IN (${ids.join(',')})',
    );
  }

  // Métodos para manejar rutas offline
  Future<void> saveRoute(Map<String, dynamic> route) async {
    final db = await database;
    await db.insert('routes', route);
  }

  Future<void> saveRoutePoint(Map<String, dynamic> point) async {
    final db = await database;
    await db.insert('route_points', point);
  }

  Future<List<Map<String, dynamic>>> getActiveRoute() async {
    final db = await database;
    return await db.query(
      'routes',
      where: "state IN ('notStarted', 'inProgress', 'paused')",
      limit: 1,
    );
  }

  Future<List<Map<String, dynamic>>> getRoutePoints(String routeId) async {
    final db = await database;
    return await db.query(
      'route_points',
      where: 'route_id = ?',
      whereArgs: [routeId],
      orderBy: 'estimated_arrival ASC',
    );
  }

  Future<void> updateRoutePointStatus({
    required String pointId,
    required bool isCompleted,
    DateTime? actualArrival,
  }) async {
    final db = await database;
    await db.update(
      'route_points',
      {
        'is_completed': isCompleted ? 1 : 0,
        'actual_arrival': actualArrival?.millisecondsSinceEpoch,
        'is_synced': 0,
      },
      where: 'id = ?',
      whereArgs: [pointId],
    );
  }

  Future<void> updateRouteStatus({
    required String routeId,
    required String state,
  }) async {
    final db = await database;
    await db.update(
      'routes',
      {
        'state': state,
        'is_synced': 0,
      },
      where: 'id = ?',
      whereArgs: [routeId],
    );
  }
} 