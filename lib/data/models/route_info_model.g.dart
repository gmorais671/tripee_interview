// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CoordinatesModelImpl _$$CoordinatesModelImplFromJson(
  Map<String, dynamic> json,
) => _$CoordinatesModelImpl(
  lat: (json['lat'] as num).toDouble(),
  lng: (json['lng'] as num).toDouble(),
);

Map<String, dynamic> _$$CoordinatesModelImplToJson(
  _$CoordinatesModelImpl instance,
) => <String, dynamic>{'lat': instance.lat, 'lng': instance.lng};

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
      distance: (json['distance_meters'] as num?)?.toInt(),
      duration: (json['duration_seconds'] as num?)?.toInt(),
      bounds: json['bounds'] == null
          ? null
          : BoundsModel.fromJson(json['bounds'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RouteInfoModelImplToJson(
  _$RouteInfoModelImpl instance,
) => <String, dynamic>{
  'polyline': instance.polyline,
  'distance_meters': instance.distance,
  'duration_seconds': instance.duration,
  'bounds': instance.bounds,
};
