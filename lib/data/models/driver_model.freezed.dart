// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DriverModel _$DriverModelFromJson(Map<String, dynamic> json) {
  return _DriverModel.fromJson(json);
}

/// @nodoc
mixin _$DriverModel {
  String get name => throw _privateConstructorUsedError;
  String get car => throw _privateConstructorUsedError;
  String get plate => throw _privateConstructorUsedError;
  String? get photo => throw _privateConstructorUsedError;

  /// Serializes this DriverModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DriverModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DriverModelCopyWith<DriverModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverModelCopyWith<$Res> {
  factory $DriverModelCopyWith(
    DriverModel value,
    $Res Function(DriverModel) then,
  ) = _$DriverModelCopyWithImpl<$Res, DriverModel>;
  @useResult
  $Res call({String name, String car, String plate, String? photo});
}

/// @nodoc
class _$DriverModelCopyWithImpl<$Res, $Val extends DriverModel>
    implements $DriverModelCopyWith<$Res> {
  _$DriverModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DriverModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? car = null,
    Object? plate = null,
    Object? photo = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            car: null == car
                ? _value.car
                : car // ignore: cast_nullable_to_non_nullable
                      as String,
            plate: null == plate
                ? _value.plate
                : plate // ignore: cast_nullable_to_non_nullable
                      as String,
            photo: freezed == photo
                ? _value.photo
                : photo // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DriverModelImplCopyWith<$Res>
    implements $DriverModelCopyWith<$Res> {
  factory _$$DriverModelImplCopyWith(
    _$DriverModelImpl value,
    $Res Function(_$DriverModelImpl) then,
  ) = __$$DriverModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String car, String plate, String? photo});
}

/// @nodoc
class __$$DriverModelImplCopyWithImpl<$Res>
    extends _$DriverModelCopyWithImpl<$Res, _$DriverModelImpl>
    implements _$$DriverModelImplCopyWith<$Res> {
  __$$DriverModelImplCopyWithImpl(
    _$DriverModelImpl _value,
    $Res Function(_$DriverModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DriverModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? car = null,
    Object? plate = null,
    Object? photo = freezed,
  }) {
    return _then(
      _$DriverModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        car: null == car
            ? _value.car
            : car // ignore: cast_nullable_to_non_nullable
                  as String,
        plate: null == plate
            ? _value.plate
            : plate // ignore: cast_nullable_to_non_nullable
                  as String,
        photo: freezed == photo
            ? _value.photo
            : photo // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DriverModelImpl extends _DriverModel {
  const _$DriverModelImpl({
    required this.name,
    required this.car,
    required this.plate,
    this.photo,
  }) : super._();

  factory _$DriverModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DriverModelImplFromJson(json);

  @override
  final String name;
  @override
  final String car;
  @override
  final String plate;
  @override
  final String? photo;

  @override
  String toString() {
    return 'DriverModel(name: $name, car: $car, plate: $plate, photo: $photo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.car, car) || other.car == car) &&
            (identical(other.plate, plate) || other.plate == plate) &&
            (identical(other.photo, photo) || other.photo == photo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, car, plate, photo);

  /// Create a copy of DriverModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverModelImplCopyWith<_$DriverModelImpl> get copyWith =>
      __$$DriverModelImplCopyWithImpl<_$DriverModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DriverModelImplToJson(this);
  }
}

abstract class _DriverModel extends DriverModel {
  const factory _DriverModel({
    required final String name,
    required final String car,
    required final String plate,
    final String? photo,
  }) = _$DriverModelImpl;
  const _DriverModel._() : super._();

  factory _DriverModel.fromJson(Map<String, dynamic> json) =
      _$DriverModelImpl.fromJson;

  @override
  String get name;
  @override
  String get car;
  @override
  String get plate;
  @override
  String? get photo;

  /// Create a copy of DriverModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DriverModelImplCopyWith<_$DriverModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
