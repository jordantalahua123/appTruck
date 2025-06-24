// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TripRouteImpl _$$TripRouteImplFromJson(Map<String, dynamic> json) =>
    _$TripRouteImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      points: (json['points'] as List<dynamic>)
          .map((e) => RoutePoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      estimatedDurationMinutes:
          (json['estimatedDurationMinutes'] as num).toInt(),
      totalDistanceKm: (json['totalDistanceKm'] as num).toDouble(),
      state: $enumDecodeNullable(_$TripStateEnumMap, json['state']) ??
          TripState.notStarted,
      driverId: json['driverId'] as String?,
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$TripRouteImplToJson(_$TripRouteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'points': instance.points,
      'createdAt': instance.createdAt.toIso8601String(),
      'estimatedDurationMinutes': instance.estimatedDurationMinutes,
      'totalDistanceKm': instance.totalDistanceKm,
      'state': _$TripStateEnumMap[instance.state]!,
      'driverId': instance.driverId,
      'startedAt': instance.startedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'notes': instance.notes,
    };

const _$TripStateEnumMap = {
  TripState.notStarted: 'notStarted',
  TripState.inProgress: 'inProgress',
  TripState.paused: 'paused',
  TripState.delayed: 'delayed',
  TripState.completed: 'completed',
  TripState.cancelled: 'cancelled',
};
