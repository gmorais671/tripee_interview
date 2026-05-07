// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DriverModelImpl _$$DriverModelImplFromJson(Map<String, dynamic> json) =>
    _$DriverModelImpl(
      name: json['name'] as String,
      car: json['car'] as String,
      plate: json['plate'] as String,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$$DriverModelImplToJson(_$DriverModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'car': instance.car,
      'plate': instance.plate,
      'photo': instance.photo,
    };
