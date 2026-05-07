// test/usecases/get_schedules_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tripee_interview/domain/usecases/get_schedules.dart';
import 'package:tripee_interview/domain/repositories/schedule_repository.dart';
import 'package:tripee_interview/domain/entities/schedule.dart';

// Mock do repo
class MockScheduleRepository extends Mock implements ScheduleRepository {}

void main() {
  late MockScheduleRepository mockRepo;
  late GetSchedules usecase;

  setUp(() {
    mockRepo = MockScheduleRepository();
    usecase = GetSchedules(mockRepo);
  });

  test('call should return list of Schedule from repository', () async {
    final schedules = [
      Schedule(
        id: '1',
        scheduleAt: DateTime.parse('2026-05-01T08:00:00.000Z'),
        startAddress: 'A',
        endAddress: 'B',
        status: 'confirmed',
      ),
    ];

    when(() => mockRepo.getSchedules(page: 1, limit: 15)).thenAnswer((_) async => schedules);

    final result = await usecase.call(page: 1, limit: 15);

    expect(result, isA<List<Schedule>>());
    expect(result.length, 1);
    expect(result.first.id, '1');

    verify(() => mockRepo.getSchedules(page: 1, limit: 15)).called(1);
  });
}