import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripee_interview/domain/entities/location.dart';
import '../../domain/entities/route_info.dart';

part 'route_info_model.freezed.dart';
part 'route_info_model.g.dart';

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
class BoundsModel with _$BoundsModel {
  const factory BoundsModel({
    CoordinatesModel? northeast,
    CoordinatesModel? southwest,
  }) = _BoundsModel;

  factory BoundsModel.fromJson(Map<String, dynamic> json) =>
      _$BoundsModelFromJson(json);

  const BoundsModel._();
  Bounds toEntity() => Bounds(
        northeast: northeast?.toEntity(),
        southwest: southwest?.toEntity(),
      );
}

@freezed
class RouteInfoModel with _$RouteInfoModel {
  const factory RouteInfoModel({
    String? polyline,
    @JsonKey(name: 'distance_meters') int? distance,
    @JsonKey(name: 'duration_seconds') int? duration,
    BoundsModel? bounds,
  }) = _RouteInfoModel;

  factory RouteInfoModel.fromJson(Map<String, dynamic> json) =>
      _$RouteInfoModelFromJson(json);

  const RouteInfoModel._();
  RouteInfo toEntity() => RouteInfo(
        polyline: polyline,
        bounds: bounds?.toEntity(),
        distance: distance,
        duration: duration,
      );
}