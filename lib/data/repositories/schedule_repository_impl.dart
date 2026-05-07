import '../../domain/entities/schedule.dart';
import '../../domain/entities/trip.dart';
import '../../domain/repositories/schedule_repository.dart';
import '../datasources/schedule_remote_datasource.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleRemoteDataSource remote;

  ScheduleRepositoryImpl(this.remote);

  @override
  Future<List<Schedule>> getSchedules({int page = 1, int limit = 15}) async {
    final models = await remote.getSchedules(page: page, limit: limit);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Trip> getScheduleDetail(String id) async {
    final model = await remote.getScheduleDetail(id);
    return model.toEntity();
  }
}