import '../entities/schedule.dart';
import '../entities/trip.dart';

abstract class ScheduleRepository {
  Future<List<Schedule>> getSchedules({int page = 1, int limit = 15});
  Future<Trip> getScheduleDetail(String id);
}