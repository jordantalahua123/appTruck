import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/map_provider.dart';
import 'map_screen.dart';

class SelectRouteScreen extends StatelessWidget {
  const SelectRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Ruta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Seleccione una acción:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildActionButton(
              context,
              'Crear Nueva Ruta',
              Icons.add_road,
              () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const MapScreen(
                      isDriverMode: false,
                      startRoutePlanning: true,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildActionButton(
              context,
              'Ver Rutas Existentes',
              Icons.map,
              () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => const MapScreen(isDriverMode: false),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
} 