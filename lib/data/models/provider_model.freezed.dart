// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'provider_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProviderModel _$ProviderModelFromJson(Map<String, dynamic> json) {
  return _ProviderModel.fromJson(json);
}

/// @nodoc
mixin _$ProviderModel {
  String get name => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;

  /// Serializes this ProviderModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProviderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProviderModelCopyWith<ProviderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProviderModelCopyWith<$Res> {
  factory $ProviderModelCopyWith(
    ProviderModel value,
    $Res Function(ProviderModel) then,
  ) = _$ProviderModelCopyWithImpl<$Res, ProviderModel>;
  @useResult
  $Res call({String name, String? category, String? logo});
}

/// @nodoc
class _$ProviderModelCopyWithImpl<$Res, $Val extends ProviderModel>
    implements $ProviderModelCopyWith<$Res> {
  _$ProviderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProviderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? category = freezed,
    Object? logo = freezed,
  }) {
    return _then(
      _value.copyWith(
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
            logo: freezed == logo
                ? _value.logo
                : logo // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProviderModelImplCopyWith<$Res>
    implements $ProviderModelCopyWith<$Res> {
  factory _$$ProviderModelImplCopyWith(
    _$ProviderModelImpl value,
    $Res Function(_$ProviderModelImpl) then,
  ) = __$$ProviderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String? category, String? logo});
}

/// @nodoc
class __$$ProviderModelImplCopyWithImpl<$Res>
    extends _$ProviderModelCopyWithImpl<$Res, _$ProviderModelImpl>
    implements _$$ProviderModelImplCopyWith<$Res> {
  __$$ProviderModelImplCopyWithImpl(
    _$ProviderModelImpl _value,
    $Res Function(_$ProviderModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProviderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? category = freezed,
    Object? logo = freezed,
  }) {
    return _then(
      _$ProviderModelImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
        logo: freezed == logo
            ? _value.logo
            : logo // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProviderModelImpl extends _ProviderModel {
  const _$ProviderModelImpl({required this.name, this.category, this.logo})
    : super._();

  factory _$ProviderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProviderModelImplFromJson(json);

  @override
  final String name;
  @override
  final String? category;
  @override
  final String? logo;

  @override
  String toString() {
    return 'ProviderModel(name: $name, category: $category, logo: $logo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProviderModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.logo, logo) || other.logo == logo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, category, logo);

  /// Create a copy of ProviderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProviderModelImplCopyWith<_$ProviderModelImpl> get copyWith =>
      __$$ProviderModelImplCopyWithImpl<_$ProviderModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProviderModelImplToJson(this);
  }
}

abstract class _ProviderModel extends ProviderModel {
  const factory _ProviderModel({
    required final String name,
    final String? category,
    final String? logo,
  }) = _$ProviderModelImpl;
  const _ProviderModel._() : super._();

  factory _ProviderModel.fromJson(Map<String, dynamic> json) =
      _$ProviderModelImpl.fromJson;

  @override
  String get name;
  @override
  String? get category;
  @override
  String? get logo;

  /// Create a copy of ProviderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProviderModelImplCopyWith<_$ProviderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
