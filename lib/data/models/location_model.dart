import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/location.dart';

part 'location_model.freezed.dart';
part 'location_model.g.dart';

@freezed
class CoordinatesModel with _$CoordinatesModel {
  const factory CoordinatesModel({
    required double lat,
    required double lng,
  }) = _CoordinatesModel;

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) =>
      _$CoordinatesModelFromJson(json);

  const CoordinatesModel._();
  Coordinates toEntity() => Coordinates(lat: lat, lng: lng);
}

@freezed
class LocationDetailModel with _$LocationDetailModel {
  const factory LocationDetailModel({
    required String address,
    String? neighborhood,
    String? city,
    String? state,
    String? country,
    String? zipcode,
    CoordinatesModel? coordinates,
  }) = _LocationDetailModel;

  factory LocationDetailModel.fromJson(Map<String, dynamic> json) =>
      _$LocationDetailModelFromJson(json);

  const LocationDetailModel._();
  LocationDetail toEntity() => LocationDetail(
        address: address,
        neighborhood: neighborhood,
        city: city,
        state: state,
        country: country,
        zipcode: zipcode,
        coordinates: coordinates?.toEntity(),
      );
}