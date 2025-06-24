import 'package:flutter/material.dart';
import '../driver/select_driver_screen.dart';
import '../map/select_route_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.blueAccent],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Selecciona tu Rol',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 50),
                _buildRoleButton(
                  context,
                  'Conductor',
                  Icons.local_shipping,
                  isDriver: true,
                ),
                const SizedBox(height: 20),
                _buildRoleButton(
                  context,
                  'Administrador',
                  Icons.admin_panel_settings,
                  isDriver: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton(
    BuildContext context,
    String title,
    IconData icon, {
    required bool isDriver,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(20),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => isDriver 
                ? const SelectDriverScreen()
                : const SelectRouteScreen(),
            ),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 