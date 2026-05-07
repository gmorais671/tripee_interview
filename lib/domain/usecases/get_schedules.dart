import '../repositories/schedule_repository.dart';
import '../entities/schedule.dart';

class GetSchedules {
  final ScheduleRepository repository;
  GetSchedules(this.repository);

  Future<List<Schedule>> call({int page = 1, int limit = 15}) =>
      repository.getSchedules(page: page, limit: limit);
}