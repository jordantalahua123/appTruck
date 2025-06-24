import '../models/route_point.dart';
import '../models/trip_route.dart';

abstract class RouteRepository {
  Future<List<TripRoute>> getAllRoutes();
  Future<TripRoute> getRouteById(String id);
  Future<TripRoute> createRoute(TripRoute route);
  Future<TripRoute> updateRoute(TripRoute route);
  Future<void> deleteRoute(String id);
  Future<void> updateRouteState(String id, TripState newState);
  Future<void> addRoutePoint(String routeId, RoutePoint point);
  Future<void> updateRoutePoint(String routeId, RoutePoint point);
  Future<void> deleteRoutePoint(String routeId, String pointId);
} 