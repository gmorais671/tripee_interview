class Coordinates {
  final double lat;
  final double lng;

  const Coordinates({
    required this.lat,
    required this.lng,
  });
}

class LocationDetail {
  final String address;
  final String? neighborhood;
  final String? city;
  final String? state;
  final String? country;
  final String? zipcode;
  final Coordinates? coordinates;

  const LocationDetail({
    required this.address,
    this.neighborhood,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.coordinates,
  });
}