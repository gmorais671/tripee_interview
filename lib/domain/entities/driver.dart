class Driver {
  final String name;
  final String car;
  final String plate;
  final String? photo;

  const Driver({
    required this.name,
    required this.car,
    required this.plate,
    this.photo,
  });
}