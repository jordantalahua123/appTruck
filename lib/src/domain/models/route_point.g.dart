// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoutePointImpl _$$RoutePointImplFromJson(Map<String, dynamic> json) =>
    _$RoutePointImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      estimatedArrival: DateTime.parse(json['estimatedArrival'] as String),
      actualArrival: json['actualArrival'] == null
          ? null
          : DateTime.parse(json['actualArrival'] as String),
      isCompleted: json['isCompleted'] as bool? ?? false,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$RoutePointImplToJson(_$RoutePointImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'estimatedArrival': instance.estimatedArrival.toIso8601String(),
      'actualArrival': instance.actualArrival?.toIso8601String(),
      'isCompleted': instance.isCompleted,
      'notes': instance.notes,
    };
