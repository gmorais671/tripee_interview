// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'route_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BoundsModel _$BoundsModelFromJson(Map<String, dynamic> json) {
  return _BoundsModel.fromJson(json);
}

/// @nodoc
mixin _$BoundsModel {
  CoordinatesModel? get northeast => throw _privateConstructorUsedError;
  CoordinatesModel? get southwest => throw _privateConstructorUsedError;

  /// Serializes this BoundsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BoundsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BoundsModelCopyWith<BoundsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoundsModelCopyWith<$Res> {
  factory $BoundsModelCopyWith(
    BoundsModel value,
    $Res Function(BoundsModel) then,
  ) = _$BoundsModelCopyWithImpl<$Res, BoundsModel>;
  @useResult
  $Res call({CoordinatesModel? northeast, CoordinatesModel? southwest});

  $CoordinatesModelCopyWith<$Res>? get northeast;
  $CoordinatesModelCopyWith<$Res>? get southwest;
}

/// @nodoc
class _$BoundsModelCopyWithImpl<$Res, $Val extends BoundsModel>
    implements $BoundsModelCopyWith<$Res> {
  _$BoundsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BoundsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? northeast = freezed, Object? southwest = freezed}) {
    return _then(
      _value.copyWith(
            northeast: freezed == northeast
                ? _value.northeast
                : northeast // ignore: cast_nullable_to_non_nullable
                      as CoordinatesModel?,
            southwest: freezed == southwest
                ? _value.southwest
                : southwest // ignore: cast_nullable_to_non_nullable
                      as CoordinatesModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of BoundsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CoordinatesModelCopyWith<$Res>? get northeast {
    if (_value.northeast == null) {
      return null;
    }

    return $CoordinatesModelCopyWith<$Res>(_value.northeast!, (value) {
      return _then(_value.copyWith(northeast: value) as $Val);
    });
  }

  /// Create a copy of BoundsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CoordinatesModelCopyWith<$Res>? get southwest {
    if (_value.southwest == null) {
      return null;
    }

    return $CoordinatesModelCopyWith<$Res>(_value.southwest!, (value) {
      return _then(_value.copyWith(southwest: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BoundsModelImplCopyWith<$Res>
    implements $BoundsModelCopyWith<$Res> {
  factory _$$BoundsModelImplCopyWith(
    _$BoundsModelImpl value,
    $Res Function(_$BoundsModelImpl) then,
  ) = __$$BoundsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CoordinatesModel? northeast, CoordinatesModel? southwest});

  @override
  $CoordinatesModelCopyWith<$Res>? get northeast;
  @override
  $CoordinatesModelCopyWith<$Res>? get southwest;
}

/// @nodoc
class __$$BoundsModelImplCopyWithImpl<$Res>
    extends _$BoundsModelCopyWithImpl<$Res, _$BoundsModelImpl>
    implements _$$BoundsModelImplCopyWith<$Res> {
  __$$BoundsModelImplCopyWithImpl(
    _$BoundsModelImpl _value,
    $Res Function(_$BoundsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoundsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? northeast = freezed, Object? southwest = freezed}) {
    return _then(
      _$BoundsModelImpl(
        northeast: freezed == northeast
            ? _value.northeast
            : northeast // ignore: cast_nullable_to_non_nullable
                  as CoordinatesModel?,
        southwest: freezed == southwest
            ? _value.southwest
            : southwest // ignore: cast_nullable_to_non_nullable
                  as CoordinatesModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BoundsModelImpl extends _BoundsModel {
  const _$BoundsModelImpl({this.northeast, this.southwest}) : super._();

  factory _$BoundsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoundsModelImplFromJson(json);

  @override
  final CoordinatesModel? northeast;
  @override
  final CoordinatesModel? southwest;

  @override
  String toString() {
    return 'BoundsModel(northeast: $northeast, southwest: $southwest)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoundsModelImpl &&
            (identical(other.northeast, northeast) ||
                other.northeast == northeast) &&
            (identical(other.southwest, southwest) ||
                other.southwest == southwest));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, northeast, southwest);

  /// Create a copy of BoundsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoundsModelImplCopyWith<_$BoundsModelImpl> get copyWith =>
      __$$BoundsModelImplCopyWithImpl<_$BoundsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoundsModelImplToJson(this);
  }
}

abstract class _BoundsModel extends BoundsModel {
  const factory _BoundsModel({
    final CoordinatesModel? northeast,
    final CoordinatesModel? southwest,
  }) = _$BoundsModelImpl;
  const _BoundsModel._() : super._();

  factory _BoundsModel.fromJson(Map<String, dynamic> json) =
      _$BoundsModelImpl.fromJson;

  @override
  CoordinatesModel? get northeast;
  @override
  CoordinatesModel? get southwest;

  /// Create a copy of BoundsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoundsModelImplCopyWith<_$BoundsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RouteInfoModel _$RouteInfoModelFromJson(Map<String, dynamic> json) {
  return _RouteInfoModel.fromJson(json);
}

/// @nodoc
mixin _$RouteInfoModel {
  String? get polyline => throw _privateConstructorUsedError;
  BoundsModel? get bounds => throw _privateConstructorUsedError;
  int? get distance => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError;

  /// Serializes this RouteInfoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RouteInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RouteInfoModelCopyWith<RouteInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RouteInfoModelCopyWith<$Res> {
  factory $RouteInfoModelCopyWith(
    RouteInfoModel value,
    $Res Function(RouteInfoModel) then,
  ) = _$RouteInfoModelCopyWithImpl<$Res, RouteInfoModel>;
  @useResult
  $Res call({
    String? polyline,
    BoundsModel? bounds,
    int? distance,
    int? duration,
  });

  $BoundsModelCopyWith<$Res>? get bounds;
}

/// @nodoc
class _$RouteInfoModelCopyWithImpl<$Res, $Val extends RouteInfoModel>
    implements $RouteInfoModelCopyWith<$Res> {
  _$RouteInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RouteInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? polyline = freezed,
    Object? bounds = freezed,
    Object? distance = freezed,
    Object? duration = freezed,
  }) {
    return _then(
      _value.copyWith(
            polyline: freezed == polyline
                ? _value.polyline
                : polyline // ignore: cast_nullable_to_non_nullable
                      as String?,
            bounds: freezed == bounds
                ? _value.bounds
                : bounds // ignore: cast_nullable_to_non_nullable
                      as BoundsModel?,
            distance: freezed == distance
                ? _value.distance
                : distance // ignore: cast_nullable_to_non_nullable
                      as int?,
            duration: freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }

  /// Create a copy of RouteInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BoundsModelCopyWith<$Res>? get bounds {
    if (_value.bounds == null) {
      return null;
    }

    return $BoundsModelCopyWith<$Res>(_value.bounds!, (value) {
      return _then(_value.copyWith(bounds: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RouteInfoModelImplCopyWith<$Res>
    implements $RouteInfoModelCopyWith<$Res> {
  factory _$$RouteInfoModelImplCopyWith(
    _$RouteInfoModelImpl value,
    $Res Function(_$RouteInfoModelImpl) then,
  ) = __$$RouteInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? polyline,
    BoundsModel? bounds,
    int? distance,
    int? duration,
  });

  @override
  $BoundsModelCopyWith<$Res>? get bounds;
}

/// @nodoc
class __$$RouteInfoModelImplCopyWithImpl<$Res>
    extends _$RouteInfoModelCopyWithImpl<$Res, _$RouteInfoModelImpl>
    implements _$$RouteInfoModelImplCopyWith<$Res> {
  __$$RouteInfoModelImplCopyWithImpl(
    _$RouteInfoModelImpl _value,
    $Res Function(_$RouteInfoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RouteInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? polyline = freezed,
    Object? bounds = freezed,
    Object? distance = freezed,
    Object? duration = freezed,
  }) {
    return _then(
      _$RouteInfoModelImpl(
        polyline: freezed == polyline
            ? _value.polyline
            : polyline // ignore: cast_nullable_to_non_nullable
                  as String?,
        bounds: freezed == bounds
            ? _value.bounds
            : bounds // ignore: cast_nullable_to_non_nullable
                  as BoundsModel?,
        distance: freezed == distance
            ? _value.distance
            : distance // ignore: cast_nullable_to_non_nullable
                  as int?,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RouteInfoModelImpl extends _RouteInfoModel {
  const _$RouteInfoModelImpl({
    this.polyline,
    this.bounds,
    this.distance,
    this.duration,
  }) : super._();

  factory _$RouteInfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RouteInfoModelImplFromJson(json);

  @override
  final String? polyline;
  @override
  final BoundsModel? bounds;
  @override
  final int? distance;
  @override
  final int? duration;

  @override
  String toString() {
    return 'RouteInfoModel(polyline: $polyline, bounds: $bounds, distance: $distance, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RouteInfoModelImpl &&
            (identical(other.polyline, polyline) ||
                other.polyline == polyline) &&
            (identical(other.bounds, bounds) || other.bounds == bounds) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, polyline, bounds, distance, duration);

  /// Create a copy of RouteInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RouteInfoModelImplCopyWith<_$RouteInfoModelImpl> get copyWith =>
      __$$RouteInfoModelImplCopyWithImpl<_$RouteInfoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RouteInfoModelImplToJson(this);
  }
}

abstract class _RouteInfoModel extends RouteInfoModel {
  const factory _RouteInfoModel({
    final String? polyline,
    final BoundsModel? bounds,
    final int? distance,
    final int? duration,
  }) = _$RouteInfoModelImpl;
  const _RouteInfoModel._() : super._();

  factory _RouteInfoModel.fromJson(Map<String, dynamic> json) =
      _$RouteInfoModelImpl.fromJson;

  @override
  String? get polyline;
  @override
  BoundsModel? get bounds;
  @override
  int? get distance;
  @override
  int? get duration;

  /// Create a copy of RouteInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RouteInfoModelImplCopyWith<_$RouteInfoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
