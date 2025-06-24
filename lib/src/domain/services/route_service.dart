import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import '../../core/config/app_config.dart';

class RouteService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>?> getRoute(List<LatLng> points) async {
    if (points.length < 2) return null;

    final coordinates = points.map((point) => 
      '${point.longitude},${point.latitude}'
    ).join(';');

    try {
      final response = await _dio.get(
        '${AppConfig.osrmBaseUrl}$coordinates',
        queryParameters: {
          'overview': 'full',
          'geometries': 'geojson',
          'steps': 'true',
          'annotations': 'true',
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<LatLng>?> getRouteGeometry(List<LatLng> points) async {
    final routeData = await getRoute(points);
    if (routeData == null) return null;

    try {
      final routes = routeData['routes'] as List;
      if (routes.isEmpty) return null;

      final geometry = routes[0]['geometry'];
      final coordinates = geometry['coordinates'] as List;

      return coordinates.map((coord) {
        final lng = (coord[0] as num).toDouble();
        final lat = (coord[1] as num).toDouble();
        return LatLng(lat, lng);
      }).toList();
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getRouteDetails(List<LatLng> points) async {
    final routeData = await getRoute(points);
    if (routeData == null) return null;

    try {
      final routes = routeData['routes'] as List;
      if (routes.isEmpty) return null;

      final route = routes[0];
      final distance = route['distance'] as num;
      final duration = route['duration'] as num;

      return {
        'distance': distance,
        'duration': duration,
        'geometry': route['geometry'],
      };
    } catch (e) {
      return null;
    }
  }
} 