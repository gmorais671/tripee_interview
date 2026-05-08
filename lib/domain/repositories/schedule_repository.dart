import 'package:tripee_interview/core/utils/pagination.dart';

import '../entities/schedule.dart';
import '../entities/trip.dart';

abstract class ScheduleRepository {
  Future<PaginatedResult<Schedule>> getSchedules({
    int page = 1,
    int limit = 15,
    DateTime? dateFrom,
    DateTime? dateTo,
    String? query,
  });

  Future<Trip> getScheduleDetail(String id);
}