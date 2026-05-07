// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trip_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TripModel _$TripModelFromJson(Map<String, dynamic> json) {
  return _TripModel.fromJson(json);
}

/// @nodoc
mixin _$TripModel {
  @JsonKey(name: 'schedule_at')
  DateTime? get scheduleAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_date')
  DateTime? get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_date')
  DateTime? get endDate => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  LocationDetailModel get start => throw _privateConstructorUsedError;
  LocationDetailModel get end => throw _privateConstructorUsedError;
  RouteInfoModel? get route => throw _privateConstructorUsedError;
  @JsonKey(name: 'estimate_route')
  RouteInfoModel? get estimateRoute => throw _privateConstructorUsedError;
  DriverModel? get driver => throw _privateConstructorUsedError;
  @JsonKey(name: 'provider')
  ProviderModel? get provider => throw _privateConstructorUsedError;

  /// Serializes this TripModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TripModelCopyWith<TripModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TripModelCopyWith<$Res> {
  factory $TripModelCopyWith(TripModel value, $Res Function(TripModel) then) =
      _$TripModelCopyWithImpl<$Res, TripModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'schedule_at') DateTime? scheduleAt,
    @JsonKey(name: 'start_date') DateTime? startDate,
    @JsonKey(name: 'end_date') DateTime? endDate,
    String status,
    LocationDetailModel start,
    LocationDetailModel end,
    RouteInfoModel? route,
    @JsonKey(name: 'estimate_route') RouteInfoModel? estimateRoute,
    DriverModel? driver,
    @JsonKey(name: 'provider') ProviderModel? provider,
  });

  $LocationDetailModelCopyWith<$Res> get start;
  $LocationDetailModelCopyWith<$Res> get end;
  $RouteInfoModelCopyWith<$Res>? get route;
  $RouteInfoModelCopyWith<$Res>? get estimateRoute;
  $DriverModelCopyWith<$Res>? get driver;
  $ProviderModelCopyWith<$Res>? get provider;
}

/// @nodoc
class _$TripModelCopyWithImpl<$Res, $Val extends TripModel>
    implements $TripModelCopyWith<$Res> {
  _$TripModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scheduleAt = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? status = null,
    Object? start = null,
    Object? end = null,
    Object? route = freezed,
    Object? estimateRoute = freezed,
    Object? driver = freezed,
    Object? provider = freezed,
  }) {
    return _then(
      _value.copyWith(
            scheduleAt: freezed == scheduleAt
                ? _value.scheduleAt
                : scheduleAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            endDate: freezed == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            start: null == start
                ? _value.start
                : start // ignore: cast_nullable_to_non_nullable
                      as LocationDetailModel,
            end: null == end
                ? _value.end
                : end // ignore: cast_nullable_to_non_nullable
                      as LocationDetailModel,
            route: freezed == route
                ? _value.route
                : route // ignore: cast_nullable_to_non_nullable
                      as RouteInfoModel?,
            estimateRoute: freezed == estimateRoute
                ? _value.estimateRoute
                : estimateRoute // ignore: cast_nullable_to_non_nullable
                      as RouteInfoModel?,
            driver: freezed == driver
                ? _value.driver
                : driver // ignore: cast_nullable_to_non_nullable
                      as DriverModel?,
            provider: freezed == provider
                ? _value.provider
                : provider // ignore: cast_nullable_to_non_nullable
                      as ProviderModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationDetailModelCopyWith<$Res> get start {
    return $LocationDetailModelCopyWith<$Res>(_value.start, (value) {
      return _then(_value.copyWith(start: value) as $Val);
    });
  }

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationDetailModelCopyWith<$Res> get end {
    return $LocationDetailModelCopyWith<$Res>(_value.end, (value) {
      return _then(_value.copyWith(end: value) as $Val);
    });
  }

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RouteInfoModelCopyWith<$Res>? get route {
    if (_value.route == null) {
      return null;
    }

    return $RouteInfoModelCopyWith<$Res>(_value.route!, (value) {
      return _then(_value.copyWith(route: value) as $Val);
    });
  }

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RouteInfoModelCopyWith<$Res>? get estimateRoute {
    if (_value.estimateRoute == null) {
      return null;
    }

    return $RouteInfoModelCopyWith<$Res>(_value.estimateRoute!, (value) {
      return _then(_value.copyWith(estimateRoute: value) as $Val);
    });
  }

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DriverModelCopyWith<$Res>? get driver {
    if (_value.driver == null) {
      return null;
    }

    return $DriverModelCopyWith<$Res>(_value.driver!, (value) {
      return _then(_value.copyWith(driver: value) as $Val);
    });
  }

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProviderModelCopyWith<$Res>? get provider {
    if (_value.provider == null) {
      return null;
    }

    return $ProviderModelCopyWith<$Res>(_value.provider!, (value) {
      return _then(_value.copyWith(provider: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TripModelImplCopyWith<$Res>
    implements $TripModelCopyWith<$Res> {
  factory _$$TripModelImplCopyWith(
    _$TripModelImpl value,
    $Res Function(_$TripModelImpl) then,
  ) = __$$TripModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'schedule_at') DateTime? scheduleAt,
    @JsonKey(name: 'start_date') DateTime? startDate,
    @JsonKey(name: 'end_date') DateTime? endDate,
    String status,
    LocationDetailModel start,
    LocationDetailModel end,
    RouteInfoModel? route,
    @JsonKey(name: 'estimate_route') RouteInfoModel? estimateRoute,
    DriverModel? driver,
    @JsonKey(name: 'provider') ProviderModel? provider,
  });

  @override
  $LocationDetailModelCopyWith<$Res> get start;
  @override
  $LocationDetailModelCopyWith<$Res> get end;
  @override
  $RouteInfoModelCopyWith<$Res>? get route;
  @override
  $RouteInfoModelCopyWith<$Res>? get estimateRoute;
  @override
  $DriverModelCopyWith<$Res>? get driver;
  @override
  $ProviderModelCopyWith<$Res>? get provider;
}

/// @nodoc
class __$$TripModelImplCopyWithImpl<$Res>
    extends _$TripModelCopyWithImpl<$Res, _$TripModelImpl>
    implements _$$TripModelImplCopyWith<$Res> {
  __$$TripModelImplCopyWithImpl(
    _$TripModelImpl _value,
    $Res Function(_$TripModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scheduleAt = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? status = null,
    Object? start = null,
    Object? end = null,
    Object? route = freezed,
    Object? estimateRoute = freezed,
    Object? driver = freezed,
    Object? provider = freezed,
  }) {
    return _then(
      _$TripModelImpl(
        scheduleAt: freezed == scheduleAt
            ? _value.scheduleAt
            : scheduleAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        start: null == start
            ? _value.start
            : start // ignore: cast_nullable_to_non_nullable
                  as LocationDetailModel,
        end: null == end
            ? _value.end
            : end // ignore: cast_nullable_to_non_nullable
                  as LocationDetailModel,
        route: freezed == route
            ? _value.route
            : route // ignore: cast_nullable_to_non_nullable
                  as RouteInfoModel?,
        estimateRoute: freezed == estimateRoute
            ? _value.estimateRoute
            : estimateRoute // ignore: cast_nullable_to_non_nullable
                  as RouteInfoModel?,
        driver: freezed == driver
            ? _value.driver
            : driver // ignore: cast_nullable_to_non_nullable
                  as DriverModel?,
        provider: freezed == provider
            ? _value.provider
            : provider // ignore: cast_nullable_to_non_nullable
                  as ProviderModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TripModelImpl extends _TripModel {
  const _$TripModelImpl({
    @JsonKey(name: 'schedule_at') this.scheduleAt,
    @JsonKey(name: 'start_date') this.startDate,
    @JsonKey(name: 'end_date') this.endDate,
    required this.status,
    required this.start,
    required this.end,
    this.route,
    @JsonKey(name: 'estimate_route') this.estimateRoute,
    this.driver,
    @JsonKey(name: 'provider') this.provider,
  }) : super._();

  factory _$TripModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TripModelImplFromJson(json);

  @override
  @JsonKey(name: 'schedule_at')
  final DateTime? scheduleAt;
  @override
  @JsonKey(name: 'start_date')
  final DateTime? startDate;
  @override
  @JsonKey(name: 'end_date')
  final DateTime? endDate;
  @override
  final String status;
  @override
  final LocationDetailModel start;
  @override
  final LocationDetailModel end;
  @override
  final RouteInfoModel? route;
  @override
  @JsonKey(name: 'estimate_route')
  final RouteInfoModel? estimateRoute;
  @override
  final DriverModel? driver;
  @override
  @JsonKey(name: 'provider')
  final ProviderModel? provider;

  @override
  String toString() {
    return 'TripModel(scheduleAt: $scheduleAt, startDate: $startDate, endDate: $endDate, status: $status, start: $start, end: $end, route: $route, estimateRoute: $estimateRoute, driver: $driver, provider: $provider)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TripModelImpl &&
            (identical(other.scheduleAt, scheduleAt) ||
                other.scheduleAt == scheduleAt) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.route, route) || other.route == route) &&
            (identical(other.estimateRoute, estimateRoute) ||
                other.estimateRoute == estimateRoute) &&
            (identical(other.driver, driver) || other.driver == driver) &&
            (identical(other.provider, provider) ||
                other.provider == provider));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    scheduleAt,
    startDate,
    endDate,
    status,
    start,
    end,
    route,
    estimateRoute,
    driver,
    provider,
  );

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TripModelImplCopyWith<_$TripModelImpl> get copyWith =>
      __$$TripModelImplCopyWithImpl<_$TripModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TripModelImplToJson(this);
  }
}

abstract class _TripModel extends TripModel {
  const factory _TripModel({
    @JsonKey(name: 'schedule_at') final DateTime? scheduleAt,
    @JsonKey(name: 'start_date') final DateTime? startDate,
    @JsonKey(name: 'end_date') final DateTime? endDate,
    required final String status,
    required final LocationDetailModel start,
    required final LocationDetailModel end,
    final RouteInfoModel? route,
    @JsonKey(name: 'estimate_route') final RouteInfoModel? estimateRoute,
    final DriverModel? driver,
    @JsonKey(name: 'provider') final ProviderModel? provider,
  }) = _$TripModelImpl;
  const _TripModel._() : super._();

  factory _TripModel.fromJson(Map<String, dynamic> json) =
      _$TripModelImpl.fromJson;

  @override
  @JsonKey(name: 'schedule_at')
  DateTime? get scheduleAt;
  @override
  @JsonKey(name: 'start_date')
  DateTime? get startDate;
  @override
  @JsonKey(name: 'end_date')
  DateTime? get endDate;
  @override
  String get status;
  @override
  LocationDetailModel get start;
  @override
  LocationDetailModel get end;
  @override
  RouteInfoModel? get route;
  @override
  @JsonKey(name: 'estimate_route')
  RouteInfoModel? get estimateRoute;
  @override
  DriverModel? get driver;
  @override
  @JsonKey(name: 'provider')
  ProviderModel? get provider;

  /// Create a copy of TripModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TripModelImplCopyWith<_$TripModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
