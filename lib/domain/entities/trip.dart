import 'location.dart';
import 'route_info.dart';
import 'driver.dart';
import 'provider.dart';

class Trip {
  final DateTime? scheduleAt;
  final DateTime? startDate;
  final DateTime? endDate;
  final String status;
  final LocationDetail start;
  final LocationDetail end;
  final RouteInfo? route;
  final RouteInfo? estimateRoute;
  final Driver? driver;
  final ProviderInfo? provider;

  const Trip({
    this.scheduleAt,
    this.startDate,
    this.endDate,
    required this.status,
    required this.start,
    required this.end,
    this.route,
    this.estimateRoute,
    this.driver,
    this.provider,
  });
}