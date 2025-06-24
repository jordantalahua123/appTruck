import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../data/database/app_database.dart';

class SyncService {
  final AppDatabase _database;
  final Duration syncInterval;
  Timer? _syncTimer;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _isSyncing = false;

  SyncService({
    required AppDatabase database,
    this.syncInterval = const Duration(minutes: 5),
  }) : _database = database;

  void startSync() {
    // Iniciar monitoreo de conectividad
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen(_handleConnectivityChange);

    // Iniciar timer de sincronización
    _syncTimer = Timer.periodic(syncInterval, (_) => syncPendingData());
  }

  Future<void> _handleConnectivityChange(List<ConnectivityResult> results) async {
    if (results.contains(ConnectivityResult.mobile) || 
        results.contains(ConnectivityResult.wifi)) {
      await syncPendingData();
    }
  }

  Future<void> syncPendingData() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      // 1. Obtener ubicaciones pendientes
      final pendingLocations = await _database.getPendingLocationUpdates();
      if (pendingLocations.isNotEmpty) {
        // TODO: Enviar ubicaciones al servidor
        // await _apiService.sendLocations(pendingLocations);
        
        // Marcar como sincronizadas
        final syncedIds = pendingLocations.map((loc) => loc['id'] as int).toList();
        await _database.markLocationsAsSynced(syncedIds);
      }

      // 2. Sincronizar actualizaciones de puntos de ruta
      // TODO: Implementar sincronización de puntos de ruta

      // 3. Sincronizar estados de ruta
      // TODO: Implementar sincronización de estados de ruta

    } catch (e) {
      print('Error durante la sincronización: $e');
      // TODO: Implementar mejor manejo de errores
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> forceSyncNow() async {
    await syncPendingData();
  }

  void dispose() {
    _syncTimer?.cancel();
    _connectivitySubscription?.cancel();
  }
} 