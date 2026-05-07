// lib/domain/usecases/get_schedule_detail.dart
import '../repositories/schedule_repository.dart';
import '../entities/trip.dart';

class GetScheduleDetail {
  final ScheduleRepository repository;

  GetScheduleDetail(this.repository);

  Future<Trip> call(String id) {
    return repository.getScheduleDetail(id);
  }
}