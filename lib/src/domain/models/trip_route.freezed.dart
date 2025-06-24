// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_route.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TripRoute _$TripRouteFromJson(Map<String, dynamic> json) {
  return _TripRoute.fromJson(json);
}

/// @nodoc
mixin _$TripRoute {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<RoutePoint> get points => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  int get estimatedDurationMinutes => throw _privateConstructorUsedError;
  double get totalDistanceKm => throw _privateConstructorUsedError;
  TripState get state => throw _privateConstructorUsedError;
  String? get driverId => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this TripRoute to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TripRoute
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TripRouteCopyWith<TripRoute> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripRouteCopyWith<$Res> {
  factory $TripRouteCopyWith(TripRoute value, $Res Function(TripRoute) then) =
      _$TripRouteCopyWithImpl<$Res, TripRoute>;
  @useResult
  $Res call(
      {String id,
      String name,
      List<RoutePoint> points,
      DateTime createdAt,
      int estimatedDurationMinutes,
      double totalDistanceKm,
      TripState state,
      String? driverId,
      DateTime? startedAt,
      DateTime? completedAt,
      String? notes});
}

/// @nodoc
class _$TripRouteCopyWithImpl<$Res, $Val extends TripRoute>
    implements $TripRouteCopyWith<$Res> {
  _$TripRouteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TripRoute
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? points = null,
    Object? createdAt = null,
    Object? estimatedDurationMinutes = null,
    Object? totalDistanceKm = null,
    Object? state = null,
    Object? driverId = freezed,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as List<RoutePoint>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      estimatedDurationMinutes: null == estimatedDurationMinutes
          ? _value.estimatedDurationMinutes
          : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      totalDistanceKm: null == totalDistanceKm
          ? _value.totalDistanceKm
          : totalDistanceKm // ignore: cast_nullable_to_non_nullable
              as double,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as TripState,
      driverId: freezed == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TripRouteImplCopyWith<$Res>
    implements $TripRouteCopyWith<$Res> {
  factory _$$TripRouteImplCopyWith(
          _$TripRouteImpl value, $Res Function(_$TripRouteImpl) then) =
      __$$TripRouteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      List<RoutePoint> points,
      DateTime createdAt,
      int estimatedDurationMinutes,
      double totalDistanceKm,
      TripState state,
      String? driverId,
      DateTime? startedAt,
      DateTime? completedAt,
      String? notes});
}

/// @nodoc
class __$$TripRouteImplCopyWithImpl<$Res>
    extends _$TripRouteCopyWithImpl<$Res, _$TripRouteImpl>
    implements _$$TripRouteImplCopyWith<$Res> {
  __$$TripRouteImplCopyWithImpl(
      _$TripRouteImpl _value, $Res Function(_$TripRouteImpl) _then)
      : super(_value, _then);

  /// Create a copy of TripRoute
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? points = null,
    Object? createdAt = null,
    Object? estimatedDurationMinutes = null,
    Object? totalDistanceKm = null,
    Object? state = null,
    Object? driverId = freezed,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$TripRouteImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value._points
          : points // ignore: cast_nullable_to_non_nullable
              as List<RoutePoint>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      estimatedDurationMinutes: null == estimatedDurationMinutes
          ? _value.estimatedDurationMinutes
          : estimatedDurationMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      totalDistanceKm: null == totalDistanceKm
          ? _value.totalDistanceKm
          : totalDistanceKm // ignore: cast_nullable_to_non_nullable
              as double,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as TripState,
      driverId: freezed == driverId
          ? _value.driverId
          : driverId // ignore: cast_nullable_to_non_nullable
              as String?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TripRouteImpl implements _TripRoute {
  const _$TripRouteImpl(
      {required this.id,
      required this.name,
      required final List<RoutePoint> points,
      required this.createdAt,
      required this.estimatedDurationMinutes,
      required this.totalDistanceKm,
      this.state = TripState.notStarted,
      this.driverId,
      this.startedAt,
      this.completedAt,
      this.notes})
      : _points = points;

  factory _$TripRouteImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripRouteImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<RoutePoint> _points;
  @override
  List<RoutePoint> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  @override
  final DateTime createdAt;
  @override
  final int estimatedDurationMinutes;
  @override
  final double totalDistanceKm;
  @override
  @JsonKey()
  final TripState state;
  @override
  final String? driverId;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;
  @override
  final String? notes;

  @override
  String toString() {
    return 'TripRoute(id: $id, name: $name, points: $points, createdAt: $createdAt, estimatedDurationMinutes: $estimatedDurationMinutes, totalDistanceKm: $totalDistanceKm, state: $state, driverId: $driverId, startedAt: $startedAt, completedAt: $completedAt, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripRouteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._points, _points) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(
                    other.estimatedDurationMinutes, estimatedDurationMinutes) ||
                other.estimatedDurationMinutes == estimatedDurationMinutes) &&
            (identical(other.totalDistanceKm, totalDistanceKm) ||
                other.totalDistanceKm == totalDistanceKm) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_points),
      createdAt,
      estimatedDurationMinutes,
      totalDistanceKm,
      state,
      driverId,
      startedAt,
      completedAt,
      notes);

  /// Create a copy of TripRoute
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripRouteImplCopyWith<_$TripRouteImpl> get copyWith =>
      __$$TripRouteImplCopyWithImpl<_$TripRouteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TripRouteImplToJson(
      this,
    );
  }
}

abstract class _TripRoute implements TripRoute {
  const factory _TripRoute(
      {required final String id,
      required final String name,
      required final List<RoutePoint> points,
      required final DateTime createdAt,
      required final int estimatedDurationMinutes,
      required final double totalDistanceKm,
      final TripState state,
      final String? driverId,
      final DateTime? startedAt,
      final DateTime? completedAt,
      final String? notes}) = _$TripRouteImpl;

  factory _TripRoute.fromJson(Map<String, dynamic> json) =
      _$TripRouteImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<RoutePoint> get points;
  @override
  DateTime get createdAt;
  @override
  int get estimatedDurationMinutes;
  @override
  double get totalDistanceKm;
  @override
  TripState get state;
  @override
  String? get driverId;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get completedAt;
  @override
  String? get notes;

  /// Create a copy of TripRoute
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripRouteImplCopyWith<_$TripRouteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
