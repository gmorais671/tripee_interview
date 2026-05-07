import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tripee_interview/presentation/providers/global_providers.dart';
import 'package:tripee_interview/domain/entities/trip.dart';
import 'package:tripee_interview/domain/entities/location.dart';
import 'package:tripee_interview/domain/repositories/schedule_repository.dart';
import 'package:tripee_interview/domain/usecases/get_schedule_detail.dart';

class MockScheduleRepository extends Mock implements ScheduleRepository {}

void main() {
  late MockScheduleRepository mockRepo;
  late ProviderContainer container;

  setUp(() {
    mockRepo = MockScheduleRepository();
    container = ProviderContainer(
      overrides: [
        getScheduleDetailProvider.overrideWithValue(GetScheduleDetail(mockRepo)),
      ],
    );
  });

  tearDown(() => container.dispose());

  test('scheduleDetailProvider returns Trip via provider container', () async {
    const trip = Trip(
      status: 'confirmed',
      start: LocationDetail(address: 'A'),
      end: LocationDetail(address: 'B'),
    );

    when(() => mockRepo.getScheduleDetail('10')).thenAnswer((_) async => trip);

    final futureTrip = container.read(scheduleDetailProvider('10').future);
    final result = await futureTrip;

    expect(result, isA<Trip>());
    expect(result.status, 'confirmed');
    verify(() => mockRepo.getScheduleDetail('10')).called(1);
  });
}