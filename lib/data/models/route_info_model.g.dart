// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BoundsModelImpl _$$BoundsModelImplFromJson(
  Map<String, dynamic> json,
) => _$BoundsModelImpl(
  northeast: json['northeast'] == null
      ? null
      : CoordinatesModel.fromJson(json['northeast'] as Map<String, dynamic>),
  southwest: json['southwest'] == null
      ? null
      : CoordinatesModel.fromJson(json['southwest'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$BoundsModelImplToJson(_$BoundsModelImpl instance) =>
    <String, dynamic>{
      'northeast': instance.northeast,
      'southwest': instance.southwest,
    };

_$RouteInfoModelImpl _$$RouteInfoModelImplFromJson(Map<String, dynamic> json) =>
    _$RouteInfoModelImpl(
      polyline: json['polyline'] as String?,
      bounds: json['bounds'] == null
          ? null
          : BoundsModel.fromJson(json['bounds'] as Map<String, dynamic>),
      distance: (json['distance'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$RouteInfoModelImplToJson(
  _$RouteInfoModelImpl instance,
) => <String, dynamic>{
  'polyline': instance.polyline,
  'bounds': instance.bounds,
  'distance': instance.distance,
  'duration': instance.duration,
};
