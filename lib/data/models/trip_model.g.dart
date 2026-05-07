// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TripModelImpl _$$TripModelImplFromJson(
  Map<String, dynamic> json,
) => _$TripModelImpl(
  scheduleAt: json['schedule_at'] == null
      ? null
      : DateTime.parse(json['schedule_at'] as String),
  startDate: json['start_date'] == null
      ? null
      : DateTime.parse(json['start_date'] as String),
  endDate: json['end_date'] == null
      ? null
      : DateTime.parse(json['end_date'] as String),
  status: json['status'] as String,
  start: LocationDetailModel.fromJson(json['start'] as Map<String, dynamic>),
  end: LocationDetailModel.fromJson(json['end'] as Map<String, dynamic>),
  route: json['route'] == null
      ? null
      : RouteInfoModel.fromJson(json['route'] as Map<String, dynamic>),
  estimateRoute: json['estimate_route'] == null
      ? null
      : RouteInfoModel.fromJson(json['estimate_route'] as Map<String, dynamic>),
  driver: json['driver'] == null
      ? null
      : DriverModel.fromJson(json['driver'] as Map<String, dynamic>),
  provider: json['provider'] == null
      ? null
      : ProviderModel.fromJson(json['provider'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$TripModelImplToJson(_$TripModelImpl instance) =>
    <String, dynamic>{
      'schedule_at': instance.scheduleAt?.toIso8601String(),
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'status': instance.status,
      'start': instance.start,
      'end': instance.end,
      'route': instance.route,
      'estimate_route': instance.estimateRoute,
      'driver': instance.driver,
      'provider': instance.provider,
    };
