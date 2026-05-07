import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/schedule.dart';

part 'schedule_model.freezed.dart';
part 'schedule_model.g.dart';

@freezed
class ScheduleModel with _$ScheduleModel {
  const factory ScheduleModel({
    required String id,
    @JsonKey(name: 'schedule_at') required DateTime scheduleAt,
    @JsonKey(name: 'start_address') required String startAddress,
    @JsonKey(name: 'end_address') required String endAddress,
    required String status,
  }) = _ScheduleModel;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleModelFromJson(json);

  const ScheduleModel._();
  Schedule toEntity() => Schedule(
        id: id,
        scheduleAt: scheduleAt,
        startAddress: startAddress,
        endAddress: endAddress,
        status: status,
      );
}