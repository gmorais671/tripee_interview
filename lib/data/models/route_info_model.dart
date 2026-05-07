import 'package:freezed_annotation/freezed_annotation.dart';
import 'location_model.dart';
import '../../domain/entities/route_info.dart';

part 'route_info_model.freezed.dart';
part 'route_info_model.g.dart';

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
    BoundsModel? bounds,
    int? distance,
    int? duration,
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