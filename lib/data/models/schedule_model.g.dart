// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleModelImpl _$$ScheduleModelImplFromJson(Map<String, dynamic> json) =>
    _$ScheduleModelImpl(
      id: json['id'] as String,
      scheduleAt: DateTime.parse(json['schedule_at'] as String),
      startAddress: json['start_address'] as String,
      endAddress: json['end_address'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$ScheduleModelImplToJson(_$ScheduleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'schedule_at': instance.scheduleAt.toIso8601String(),
      'start_address': instance.startAddress,
      'end_address': instance.endAddress,
      'status': instance.status,
    };
