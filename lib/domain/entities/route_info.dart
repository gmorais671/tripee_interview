import 'location.dart';

class Bounds {
  final Coordinates? northeast;
  final Coordinates? southwest;

  const Bounds({
    this.northeast,
    this.southwest,
  });
}

class RouteInfo {
  final String? polyline;
  final Bounds? bounds;
  final int? distance;
  final int? duration;

  const RouteInfo({
    this.polyline,
    this.bounds,
    this.distance,
    this.duration,
  });
}