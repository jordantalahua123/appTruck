import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/models/trip_route.dart';
import '../providers/tracking_provider.dart';

class RouteInfoPanel extends StatelessWidget {
  const RouteInfoPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackingProvider>(
      builder: (context, trackingProvider, child) {
        final route = trackingProvider.activeRoute;
        
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (route != null) ...[
                _buildRouteHeader(route),
                const SizedBox(height: 16),
                _buildTimeInfo(trackingProvider),
                const SizedBox(height: 16),
                _buildProgressInfo(route),
                const SizedBox(height: 16),
                _buildControlButtons(context, trackingProvider),
              ] else
                const Text('No hay ruta activa'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRouteHeader(TripRoute route) {
    return Column(
      children: [
        Text(
          route.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${route.totalDistanceKm.toStringAsFixed(1)} km - ${(route.estimatedDurationMinutes / 60).toStringAsFixed(1)} horas',
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeInfo(TrackingProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildTimeInfoItem(
          'Tiempo Transcurrido',
          provider.formattedElapsedTime,
        ),
        _buildTimeInfoItem(
          'Estado',
          provider.isTracking ? 'En Progreso' : 'Detenido',
          color: provider.isTracking ? Colors.green : Colors.red,
        ),
      ],
    );
  }

  Widget _buildTimeInfoItem(String label, String value, {Color? color}) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressInfo(TripRoute route) {
    final completedPoints = route.points.where((p) => p.isCompleted).length;
    final progress = completedPoints / route.points.length;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Progreso: ${(progress * 100).toStringAsFixed(0)}%'),
            Text('$completedPoints/${route.points.length} puntos'),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ],
    );
  }

  Widget _buildControlButtons(BuildContext context, TrackingProvider provider) {
    if (!provider.isTracking) {
      return ElevatedButton(
        onPressed: () {
          if (provider.activeRoute != null) {
            provider.startTracking(provider.activeRoute!);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          minimumSize: const Size(double.infinity, 45),
        ),
        child: const Text(
          'INICIAR RUTA',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: provider.pauseTracking,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: const Text(
              'PAUSAR',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: provider.stopTracking,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'DETENER',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
} 