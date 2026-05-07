// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CoordinatesModel _$CoordinatesModelFromJson(Map<String, dynamic> json) {
  return _CoordinatesModel.fromJson(json);
}

/// @nodoc
mixin _$CoordinatesModel {
  double get lat => throw _privateConstructorUsedError;
  double get lng => throw _privateConstructorUsedError;

  /// Serializes this CoordinatesModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CoordinatesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoordinatesModelCopyWith<CoordinatesModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoordinatesModelCopyWith<$Res> {
  factory $CoordinatesModelCopyWith(
    CoordinatesModel value,
    $Res Function(CoordinatesModel) then,
  ) = _$CoordinatesModelCopyWithImpl<$Res, CoordinatesModel>;
  @useResult
  $Res call({double lat, double lng});
}

/// @nodoc
class _$CoordinatesModelCopyWithImpl<$Res, $Val extends CoordinatesModel>
    implements $CoordinatesModelCopyWith<$Res> {
  _$CoordinatesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CoordinatesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? lat = null, Object? lng = null}) {
    return _then(
      _value.copyWith(
            lat: null == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double,
            lng: null == lng
                ? _value.lng
                : lng // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CoordinatesModelImplCopyWith<$Res>
    implements $CoordinatesModelCopyWith<$Res> {
  factory _$$CoordinatesModelImplCopyWith(
    _$CoordinatesModelImpl value,
    $Res Function(_$CoordinatesModelImpl) then,
  ) = __$$CoordinatesModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double lat, double lng});
}

/// @nodoc
class __$$CoordinatesModelImplCopyWithImpl<$Res>
    extends _$CoordinatesModelCopyWithImpl<$Res, _$CoordinatesModelImpl>
    implements _$$CoordinatesModelImplCopyWith<$Res> {
  __$$CoordinatesModelImplCopyWithImpl(
    _$CoordinatesModelImpl _value,
    $Res Function(_$CoordinatesModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CoordinatesModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? lat = null, Object? lng = null}) {
    return _then(
      _$CoordinatesModelImpl(
        lat: null == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double,
        lng: null == lng
            ? _value.lng
            : lng // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CoordinatesModelImpl extends _CoordinatesModel {
  const _$CoordinatesModelImpl({required this.lat, required this.lng})
    : super._();

  factory _$CoordinatesModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoordinatesModelImplFromJson(json);

  @override
  final double lat;
  @override
  final double lng;

  @override
  String toString() {
    return 'CoordinatesModel(lat: $lat, lng: $lng)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoordinatesModelImpl &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lng, lng) || other.lng == lng));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lat, lng);

  /// Create a copy of CoordinatesModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoordinatesModelImplCopyWith<_$CoordinatesModelImpl> get copyWith =>
      __$$CoordinatesModelImplCopyWithImpl<_$CoordinatesModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CoordinatesModelImplToJson(this);
  }
}

abstract class _CoordinatesModel extends CoordinatesModel {
  const factory _CoordinatesModel({
    required final double lat,
    required final double lng,
  }) = _$CoordinatesModelImpl;
  const _CoordinatesModel._() : super._();

  factory _CoordinatesModel.fromJson(Map<String, dynamic> json) =
      _$CoordinatesModelImpl.fromJson;

  @override
  double get lat;
  @override
  double get lng;

  /// Create a copy of CoordinatesModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoordinatesModelImplCopyWith<_$CoordinatesModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LocationDetailModel _$LocationDetailModelFromJson(Map<String, dynamic> json) {
  return _LocationDetailModel.fromJson(json);
}

/// @nodoc
mixin _$LocationDetailModel {
  String get address => throw _privateConstructorUsedError;
  String? get neighborhood => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get zipcode => throw _privateConstructorUsedError;
  CoordinatesModel? get coordinates => throw _privateConstructorUsedError;

  /// Serializes this LocationDetailModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationDetailModelCopyWith<LocationDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationDetailModelCopyWith<$Res> {
  factory $LocationDetailModelCopyWith(
    LocationDetailModel value,
    $Res Function(LocationDetailModel) then,
  ) = _$LocationDetailModelCopyWithImpl<$Res, LocationDetailModel>;
  @useResult
  $Res call({
    String address,
    String? neighborhood,
    String? city,
    String? state,
    String? country,
    String? zipcode,
    CoordinatesModel? coordinates,
  });

  $CoordinatesModelCopyWith<$Res>? get coordinates;
}

/// @nodoc
class _$LocationDetailModelCopyWithImpl<$Res, $Val extends LocationDetailModel>
    implements $LocationDetailModelCopyWith<$Res> {
  _$LocationDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? neighborhood = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? zipcode = freezed,
    Object? coordinates = freezed,
  }) {
    return _then(
      _value.copyWith(
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            neighborhood: freezed == neighborhood
                ? _value.neighborhood
                : neighborhood // ignore: cast_nullable_to_non_nullable
                      as String?,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            state: freezed == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as String?,
            country: freezed == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String?,
            zipcode: freezed == zipcode
                ? _value.zipcode
                : zipcode // ignore: cast_nullable_to_non_nullable
                      as String?,
            coordinates: freezed == coordinates
                ? _value.coordinates
                : coordinates // ignore: cast_nullable_to_non_nullable
                      as CoordinatesModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of LocationDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CoordinatesModelCopyWith<$Res>? get coordinates {
    if (_value.coordinates == null) {
      return null;
    }

    return $CoordinatesModelCopyWith<$Res>(_value.coordinates!, (value) {
      return _then(_value.copyWith(coordinates: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LocationDetailModelImplCopyWith<$Res>
    implements $LocationDetailModelCopyWith<$Res> {
  factory _$$LocationDetailModelImplCopyWith(
    _$LocationDetailModelImpl value,
    $Res Function(_$LocationDetailModelImpl) then,
  ) = __$$LocationDetailModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String address,
    String? neighborhood,
    String? city,
    String? state,
    String? country,
    String? zipcode,
    CoordinatesModel? coordinates,
  });

  @override
  $CoordinatesModelCopyWith<$Res>? get coordinates;
}

/// @nodoc
class __$$LocationDetailModelImplCopyWithImpl<$Res>
    extends _$LocationDetailModelCopyWithImpl<$Res, _$LocationDetailModelImpl>
    implements _$$LocationDetailModelImplCopyWith<$Res> {
  __$$LocationDetailModelImplCopyWithImpl(
    _$LocationDetailModelImpl _value,
    $Res Function(_$LocationDetailModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocationDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? neighborhood = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? zipcode = freezed,
    Object? coordinates = freezed,
  }) {
    return _then(
      _$LocationDetailModelImpl(
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        neighborhood: freezed == neighborhood
            ? _value.neighborhood
            : neighborhood // ignore: cast_nullable_to_non_nullable
                  as String?,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        state: freezed == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as String?,
        country: freezed == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String?,
        zipcode: freezed == zipcode
            ? _value.zipcode
            : zipcode // ignore: cast_nullable_to_non_nullable
                  as String?,
        coordinates: freezed == coordinates
            ? _value.coordinates
            : coordinates // ignore: cast_nullable_to_non_nullable
                  as CoordinatesModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationDetailModelImpl extends _LocationDetailModel {
  const _$LocationDetailModelImpl({
    required this.address,
    this.neighborhood,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.coordinates,
  }) : super._();

  factory _$LocationDetailModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocationDetailModelImplFromJson(json);

  @override
  final String address;
  @override
  final String? neighborhood;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String? country;
  @override
  final String? zipcode;
  @override
  final CoordinatesModel? coordinates;

  @override
  String toString() {
    return 'LocationDetailModel(address: $address, neighborhood: $neighborhood, city: $city, state: $state, country: $country, zipcode: $zipcode, coordinates: $coordinates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationDetailModelImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.neighborhood, neighborhood) ||
                other.neighborhood == neighborhood) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.zipcode, zipcode) || other.zipcode == zipcode) &&
            (identical(other.coordinates, coordinates) ||
                other.coordinates == coordinates));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    address,
    neighborhood,
    city,
    state,
    country,
    zipcode,
    coordinates,
  );

  /// Create a copy of LocationDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationDetailModelImplCopyWith<_$LocationDetailModelImpl> get copyWith =>
      __$$LocationDetailModelImplCopyWithImpl<_$LocationDetailModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationDetailModelImplToJson(this);
  }
}

abstract class _LocationDetailModel extends LocationDetailModel {
  const factory _LocationDetailModel({
    required final String address,
    final String? neighborhood,
    final String? city,
    final String? state,
    final String? country,
    final String? zipcode,
    final CoordinatesModel? coordinates,
  }) = _$LocationDetailModelImpl;
  const _LocationDetailModel._() : super._();

  factory _LocationDetailModel.fromJson(Map<String, dynamic> json) =
      _$LocationDetailModelImpl.fromJson;

  @override
  String get address;
  @override
  String? get neighborhood;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String? get country;
  @override
  String? get zipcode;
  @override
  CoordinatesModel? get coordinates;

  /// Create a copy of LocationDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationDetailModelImplCopyWith<_$LocationDetailModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
