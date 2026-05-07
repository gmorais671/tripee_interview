class Schedule {
  final String id;
  final DateTime scheduleAt;
  final String startAddress;
  final String endAddress;
  final String status;

  const Schedule({
    required this.id,
    required this.scheduleAt,
    required this.startAddress,
    required this.endAddress,
    required this.status,
  });
}