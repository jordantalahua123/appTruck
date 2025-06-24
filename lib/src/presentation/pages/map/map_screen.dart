import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../../providers/map_provider.dart';
import '../../providers/tracking_provider.dart';
import '../../widgets/route_info_panel.dart';
import '../../../domain/models/route_point.dart';

class MapScreen extends StatelessWidget {
  final bool isDriverMode;
  final bool startRoutePlanning;

  const MapScreen({
    super.key,
    this.isDriverMode = false,
    this.startRoutePlanning = false,
  });

  @override
  Widget build(BuildContext context) {
    // Si startRoutePlanning es true, iniciamos la planificación de ruta
    if (startRoutePlanning) {
      Future.microtask(() {
        context.read<MapProvider>().toggleRoutePlanning();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isDriverMode ? 'Modo Conductor' : 'Modo Administrador'),
        actions: [
          if (!isDriverMode) // Solo mostrar en modo administrador
            IconButton(
              icon: const Icon(Icons.add_location),
              onPressed: () {
                context.read<MapProvider>().toggleRoutePlanning();
              },
            ),
        ],
      ),
      body: Consumer2<MapProvider, TrackingProvider>(
        builder: (context, mapProvider, trackingProvider, child) {
          return Stack(
            children: [
              FlutterMap(
                mapController: mapProvider.mapController,
                options: MapOptions(
                  initialCenter: mapProvider.center,
                  initialZoom: mapProvider.zoom,
                  onTap: (!isDriverMode && mapProvider.isRoutePlanning)
                      ? (tapPosition, point) {
                          final newPoint = RoutePoint(
                            id: DateTime.now().toString(),
                            name: 'Punto ${mapProvider.selectedPoints.length + 1}',
                            latitude: point.latitude,
                            longitude: point.longitude,
                            estimatedArrival: DateTime.now().add(
                              Duration(
                                minutes: (mapProvider.selectedPoints.length + 1) * 30,
                              ),
                            ),
                          );
                          mapProvider.addSelectedPoint(newPoint);
                        }
                      : null,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.indrive_clone',
                  ),
                  // Marcadores de puntos de ruta
                  MarkerLayer(
                    markers: [
                      for (var point in mapProvider.selectedPoints)
                        Marker(
                          point: LatLng(point.latitude, point.longitude),
                          child: Icon(
                            Icons.location_on,
                            color: point.isCompleted ? Colors.green : Colors.red,
                            size: 40,
                          ),
                        ),
                    ],
                  ),
                  // Marcador de posición actual (solo en modo conductor o si hay tracking activo)
                  if ((isDriverMode || trackingProvider.isTracking) &&
                      trackingProvider.currentTrack.isNotEmpty)
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: trackingProvider.currentTrack.last,
                          child: const Icon(
                            Icons.local_shipping,
                            color: Colors.blue,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  // Línea de la ruta actual
                  if (trackingProvider.currentTrack.length > 1)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: trackingProvider.currentTrack,
                          strokeWidth: 4,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                ],
              ),
              if (!isDriverMode && mapProvider.isRoutePlanning)
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Puntos seleccionados: ${mapProvider.selectedPoints.length}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: mapProvider.selectedPoints.length >= 2
                                      ? () {
                                          // TODO: Crear ruta con los puntos seleccionados
                                          mapProvider.toggleRoutePlanning();
                                        }
                                      : null,
                                  child: const Text('Crear Ruta'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: mapProvider.clearSelectedPoints,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text(
                                  'Limpiar',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: RouteInfoPanel(),
                ),
            ],
          );
        },
      ),
    );
  }
} 