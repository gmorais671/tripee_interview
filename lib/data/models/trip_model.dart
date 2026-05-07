import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tripee_interview/data/models/driver_model.dart';
import 'package:tripee_interview/data/models/location_model.dart';
import 'package:tripee_interview/data/models/provider_model.dart';
import 'package:tripee_interview/data/models/route_info_model.dart';
import 'package:tripee_interview/domain/entities/trip.dart';

part 'trip_model.freezed.dart';
part 'trip_model.g.dart';

@freezed
class TripModel with _$TripModel {
  const factory TripModel({
    @JsonKey(name: 'schedule_at') DateTime? scheduleAt,
    @JsonKey(name: 'start_date') DateTime? startDate,
    @JsonKey(name: 'end_date') DateTime? endDate,
    required String status,
    required LocationDetailModel start,
    required LocationDetailModel end,

    // Suporta ambos: "route" ou "route_info"
    @JsonKey(name: 'route') RouteInfoModel? route,
    @JsonKey(name: 'route_info') RouteInfoModel? routeInfo,

    @JsonKey(name: 'estimate_route') RouteInfoModel? estimateRoute,
    DriverModel? driver,
    @JsonKey(name: 'provider') ProviderModel? provider,
  }) = _TripModel;

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      _$TripModelFromJson(json);

  const TripModel._();

  RouteInfoModel? get effectiveRoute => route ?? routeInfo;

  Trip toEntity() => Trip(
        scheduleAt: scheduleAt,
        startDate: startDate,
        endDate: endDate,
        status: status,
        start: start.toEntity(),
        end: end.toEntity(),
        route: effectiveRoute?.toEntity(),
        estimateRoute: estimateRoute?.toEntity(),
        driver: driver?.toEntity(),
        provider: provider?.toEntity(),
      );
}