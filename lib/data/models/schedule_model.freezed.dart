// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ScheduleModel _$ScheduleModelFromJson(Map<String, dynamic> json) {
  return _ScheduleModel.fromJson(json);
}

/// @nodoc
mixin _$ScheduleModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'schedule_at')
  DateTime get scheduleAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'start_address')
  String get startAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'end_address')
  String get endAddress => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this ScheduleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduleModelCopyWith<ScheduleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleModelCopyWith<$Res> {
  factory $ScheduleModelCopyWith(
    ScheduleModel value,
    $Res Function(ScheduleModel) then,
  ) = _$ScheduleModelCopyWithImpl<$Res, ScheduleModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'schedule_at') DateTime scheduleAt,
    @JsonKey(name: 'start_address') String startAddress,
    @JsonKey(name: 'end_address') String endAddress,
    String status,
  });
}

/// @nodoc
class _$ScheduleModelCopyWithImpl<$Res, $Val extends ScheduleModel>
    implements $ScheduleModelCopyWith<$Res> {
  _$ScheduleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scheduleAt = null,
    Object? startAddress = null,
    Object? endAddress = null,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            scheduleAt: null == scheduleAt
                ? _value.scheduleAt
                : scheduleAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            startAddress: null == startAddress
                ? _value.startAddress
                : startAddress // ignore: cast_nullable_to_non_nullable
                      as String,
            endAddress: null == endAddress
                ? _value.endAddress
                : endAddress // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScheduleModelImplCopyWith<$Res>
    implements $ScheduleModelCopyWith<$Res> {
  factory _$$ScheduleModelImplCopyWith(
    _$ScheduleModelImpl value,
    $Res Function(_$ScheduleModelImpl) then,
  ) = __$$ScheduleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'schedule_at') DateTime scheduleAt,
    @JsonKey(name: 'start_address') String startAddress,
    @JsonKey(name: 'end_address') String endAddress,
    String status,
  });
}

/// @nodoc
class __$$ScheduleModelImplCopyWithImpl<$Res>
    extends _$ScheduleModelCopyWithImpl<$Res, _$ScheduleModelImpl>
    implements _$$ScheduleModelImplCopyWith<$Res> {
  __$$ScheduleModelImplCopyWithImpl(
    _$ScheduleModelImpl _value,
    $Res Function(_$ScheduleModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? scheduleAt = null,
    Object? startAddress = null,
    Object? endAddress = null,
    Object? status = null,
  }) {
    return _then(
      _$ScheduleModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        scheduleAt: null == scheduleAt
            ? _value.scheduleAt
            : scheduleAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        startAddress: null == startAddress
            ? _value.startAddress
            : startAddress // ignore: cast_nullable_to_non_nullable
                  as String,
        endAddress: null == endAddress
            ? _value.endAddress
            : endAddress // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleModelImpl extends _ScheduleModel {
  const _$ScheduleModelImpl({
    required this.id,
    @JsonKey(name: 'schedule_at') required this.scheduleAt,
    @JsonKey(name: 'start_address') required this.startAddress,
    @JsonKey(name: 'end_address') required this.endAddress,
    required this.status,
  }) : super._();

  factory _$ScheduleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'schedule_at')
  final DateTime scheduleAt;
  @override
  @JsonKey(name: 'start_address')
  final String startAddress;
  @override
  @JsonKey(name: 'end_address')
  final String endAddress;
  @override
  final String status;

  @override
  String toString() {
    return 'ScheduleModel(id: $id, scheduleAt: $scheduleAt, startAddress: $startAddress, endAddress: $endAddress, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.scheduleAt, scheduleAt) ||
                other.scheduleAt == scheduleAt) &&
            (identical(other.startAddress, startAddress) ||
                other.startAddress == startAddress) &&
            (identical(other.endAddress, endAddress) ||
                other.endAddress == endAddress) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    scheduleAt,
    startAddress,
    endAddress,
    status,
  );

  /// Create a copy of ScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleModelImplCopyWith<_$ScheduleModelImpl> get copyWith =>
      __$$ScheduleModelImplCopyWithImpl<_$ScheduleModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleModelImplToJson(this);
  }
}

abstract class _ScheduleModel extends ScheduleModel {
  const factory _ScheduleModel({
    required final String id,
    @JsonKey(name: 'schedule_at') required final DateTime scheduleAt,
    @JsonKey(name: 'start_address') required final String startAddress,
    @JsonKey(name: 'end_address') required final String endAddress,
    required final String status,
  }) = _$ScheduleModelImpl;
  const _ScheduleModel._() : super._();

  factory _ScheduleModel.fromJson(Map<String, dynamic> json) =
      _$ScheduleModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'schedule_at')
  DateTime get scheduleAt;
  @override
  @JsonKey(name: 'start_address')
  String get startAddress;
  @override
  @JsonKey(name: 'end_address')
  String get endAddress;
  @override
  String get status;

  /// Create a copy of ScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduleModelImplCopyWith<_$ScheduleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
