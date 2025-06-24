import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/driver_provider.dart';
import '../map/map_screen.dart';
import 'waiting_screen.dart';

class SelectDriverScreen extends StatefulWidget {
  const SelectDriverScreen({super.key});

  @override
  State<SelectDriverScreen> createState() => _SelectDriverScreenState();
}

class _SelectDriverScreenState extends State<SelectDriverScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar los conductores después de que el widget se haya construido
    Future.microtask(() {
      context.read<DriverProvider>().loadDrivers();
    });
  }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selecciona tu Perfil',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: Consumer<DriverProvider>(
                    builder: (context, driverProvider, child) {
                      if (driverProvider.availableDrivers.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: driverProvider.availableDrivers.length,
                        itemBuilder: (context, index) {
                          final driver = driverProvider.availableDrivers[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(
                                  driver.name[0].toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                driver.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Tel: ${driver.phoneNumber}',
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                driverProvider.setCurrentDriver(driver);
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_) => driver.currentRouteId != null
                                        ? const MapScreen(isDriverMode: true)
                                        : const WaitingScreen(),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 