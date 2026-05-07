import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tripee_interview/domain/usecases/get_schedule_detail.dart';
import 'package:tripee_interview/domain/repositories/schedule_repository.dart';
import 'package:tripee_interview/domain/entities/trip.dart';
import 'package:tripee_interview/domain/entities/location.dart';

class MockScheduleRepository extends Mock implements ScheduleRepository {}

void main() {
  late MockScheduleRepository mockRepo;
  late GetScheduleDetail usecase;

  setUp(() {
    mockRepo = MockScheduleRepository();
    usecase = GetScheduleDetail(mockRepo);
  });

  test('call returns Trip from repository', () async {
    const trip = Trip(
      status: 'confirmed',
      start: LocationDetail(address: 'A'),
      end: LocationDetail(address: 'B'),
    );

    when(() => mockRepo.getScheduleDetail('10')).thenAnswer((_) async => trip);

    final result = await usecase.call('10');
    expect(result.status, 'confirmed');
    verify(() => mockRepo.getScheduleDetail('10')).called(1);
  });
}