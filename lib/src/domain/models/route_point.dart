import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'route_point.freezed.dart';
part 'route_point.g.dart';

@freezed
class RoutePoint with _$RoutePoint {
  const factory RoutePoint({
    required String id,
    required String name,
    required double latitude,
    required double longitude,
    required DateTime estimatedArrival,
    DateTime? actualArrival,
    @Default(false) bool isCompleted,
    String? notes,
  }) = _RoutePoint;

  factory RoutePoint.fromJson(Map<String, dynamic> json) => 
      _$RoutePointFromJson(json);
} 