import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tripee_interview/data/repositories/schedule_repository_impl.dart';
import 'package:tripee_interview/data/models/schedule_model.dart';
import 'package:tripee_interview/data/datasources/schedule_remote_datasource.dart';
import 'package:tripee_interview/domain/entities/schedule.dart';

class MockRemoteDataSource extends Mock implements ScheduleRemoteDataSource {}

void main() {
  late MockRemoteDataSource mockRemote;
  late ScheduleRepositoryImpl repository;

  setUp(() {
    mockRemote = MockRemoteDataSource();
    repository = ScheduleRepositoryImpl(mockRemote);
  });

  test('getSchedules returns Entities list', () async {
    final model = ScheduleModel(
      id: '1',
      scheduleAt: DateTime.parse('2026-05-01T08:00:00.000Z'),
      startAddress: 'A',
      endAddress: 'B',
      status: 'confirmed',
    );

    when(() => mockRemote.getSchedules(page: 1, limit: 15)).thenAnswer((_) async => [model]);

    final result = await repository.getSchedules(page: 1, limit: 15);
    expect(result, isA<List<Schedule>>());
    expect(result.first.id, '1');
    verify(() => mockRemote.getSchedules(page: 1, limit: 15)).called(1);
  });
}