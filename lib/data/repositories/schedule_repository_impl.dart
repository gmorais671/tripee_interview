import 'package:tripee_interview/core/utils/pagination.dart';

import '../../domain/entities/schedule.dart';
import '../../domain/entities/trip.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../datasources/schedule_remote_datasource.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource remote;

  ScheduleRepositoryImpl(this.remote);

  @override
  Future<PaginatedResult<Schedule>> getSchedules({
    int page = 1,
    int limit = 15,
    DateTime? dateFrom,
    DateTime? dateTo,
    String? query,
  }) async {
    final result = await remote.getSchedules(
      page: page,
      limit: limit,
      dateFrom: dateFrom,
      dateTo: dateTo,
      query: query, // passou query aqui
    );

    final domainItems = result.items.map((m) => m.toEntity()).toList();
    return PaginatedResult<Schedule>(
      items: domainItems,
      page: result.page,
      limit: result.limit,
      total: result.total,
      totalPages: result.totalPages,
    );
  }

  @override
  Future<Trip> getScheduleDetail(String id) async {
    final model = await remote.getScheduleDetail(id);
    return model.toEntity();
  }
}