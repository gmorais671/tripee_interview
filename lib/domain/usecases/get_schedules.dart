import 'package:tripee_interview/core/utils/pagination.dart';

import '../repositories/schedule_repository.dart';
import '../entities/schedule.dart';

class GetSchedules {
  final ScheduleRepository repository;
  GetSchedules(this.repository);

  Future<PaginatedResult<Schedule>> call({
    int page = 1,
    int limit = 15,
    DateTime? dateFrom,
    DateTime? dateTo,
    String? query,
  }) {
    return repository.getSchedules(
      page: page,
      limit: limit,
      dateFrom: dateFrom,
      dateTo: dateTo,
      query: query,
    );
  }
}