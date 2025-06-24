import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/core/config/app_config.dart'; 
import 'src/data/database/app_database.dart';
import 'src/domain/services/location_service.dart';
import 'src/domain/services/route_service.dart';
import 'src/domain/services/sync_service.dart';
import 'src/presentation/providers/map_provider.dart';
import 'src/presentation/providers/tracking_provider.dart';
import 'src/presentation/pages/role_selection/role_selection_screen.dart';
import 'src/presentation/providers/driver_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Crear instancias de serviciosfx
  final database = AppDatabase();
  final locationService = LocationService();
  final routeService = RouteService();
  final syncService = SyncService(database: database);

  // Iniciar sincronización
  syncService.startSync();

  runApp(MyApp(
    database: database,
    locationService: locationService,
    routeService: routeService,
    syncService: syncService,
  ));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;
  final LocationService locationService;
  final RouteService routeService;
  final SyncService syncService;

  const MyApp({
    super.key,
    required this.database,
    required this.locationService,
    required this.routeService,
    required this.syncService,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MapProvider()),
        ChangeNotifierProvider(
          create: (_) => TrackingProvider(
            locationService: locationService,
            routeService: routeService,
            database: database,
          ),
        ),
        ChangeNotifierProvider(create: (_) => DriverProvider()),
      ],
      child: MaterialApp(
        title: AppConfig.appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const RoleSelectionScreen(),
      ),
    );
  }
}
