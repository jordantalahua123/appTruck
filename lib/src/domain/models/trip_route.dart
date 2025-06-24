import 'package:freezed_annotation/freezed_annotation.dart';
import 'route_point.dart';

part 'trip_route.freezed.dart';
part 'trip_route.g.dart';

enum TripState {
  notStarted,
  inProgress,
  paused,
  delayed,
  completed,
  cancelled
}

@freezed
class TripRoute with _$TripRoute {
  const factory TripRoute({
    required String id,
    required String name,
    required List<RoutePoint> points,
    required DateTime createdAt,
    required int estimatedDurationMinutes,
    required double totalDistanceKm,
    @Default(TripState.notStarted) TripState state,
    String? driverId,
    DateTime? startedAt,
    DateTime? completedAt,
    String? notes,
  }) = _TripRoute;

  factory TripRoute.fromJson(Map<String, dynamic> json) => 
      _$TripRouteFromJson(json);
} 