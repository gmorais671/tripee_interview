import 'package:freezed_annotation/freezed_annotation.dart';
import 'location_model.dart';
import 'route_info_model.dart';
import 'driver_model.dart';
import 'provider_model.dart';
import '../../domain/entities/trip.dart';

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
    RouteInfoModel? route,
    @JsonKey(name: 'estimate_route') RouteInfoModel? estimateRoute,
    DriverModel? driver,
    @JsonKey(name: 'provider') ProviderModel? provider,
  }) = _TripModel;

  factory TripModel.fromJson(Map<String, dynamic> json) =>
      _$TripModelFromJson(json);

  const TripModel._();
  Trip toEntity() => Trip(
        scheduleAt: scheduleAt,
        startDate: startDate,
        endDate: endDate,
        status: status,
        start: start.toEntity(),
        end: end.toEntity(),
        route: route?.toEntity(),
        estimateRoute: estimateRoute?.toEntity(),
        driver: driver?.toEntity(),
        provider: provider?.toEntity(),
      );
}