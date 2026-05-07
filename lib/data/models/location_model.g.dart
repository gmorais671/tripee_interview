// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

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

_$LocationDetailModelImpl _$$LocationDetailModelImplFromJson(
  Map<String, dynamic> json,
) => _$LocationDetailModelImpl(
  address: json['address'] as String,
  neighborhood: json['neighborhood'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  country: json['country'] as String?,
  zipcode: json['zipcode'] as String?,
  coordinates: json['coordinates'] == null
      ? null
      : CoordinatesModel.fromJson(json['coordinates'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$LocationDetailModelImplToJson(
  _$LocationDetailModelImpl instance,
) => <String, dynamic>{
  'address': instance.address,
  'neighborhood': instance.neighborhood,
  'city': instance.city,
  'state': instance.state,
  'country': instance.country,
  'zipcode': instance.zipcode,
  'coordinates': instance.coordinates,
};
