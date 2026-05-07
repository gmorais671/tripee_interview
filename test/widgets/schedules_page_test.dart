// test/widgets/schedules_page_test.dart (trecho)
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripee_interview/domain/entities/trip.dart';
import 'package:tripee_interview/presentation/pages/schedules_page.dart';
import 'package:tripee_interview/domain/entities/schedule.dart';
import 'package:tripee_interview/presentation/providers/global_providers.dart';
import 'package:tripee_interview/domain/repositories/schedule_repository.dart';
import 'package:tripee_interview/domain/usecases/get_schedules.dart';

// Dummy repository que implementa ScheduleRepository só para teste
class DummyScheduleRepository implements ScheduleRepository {
  @override
  Future<List<Schedule>> getSchedules({int page = 1, int limit = 15}) async {
    return [
      Schedule(
        id: '1',
        scheduleAt: DateTime.parse('2026-05-01T08:00:00.000Z'),
        startAddress: 'Av. Paulista, 1000 — Bela Vista',
        endAddress: 'Rua Oscar Freire, 300 — Jardins',
        status: 'confirmed',
      ),
    ];
  }

  @override
  Future<Trip> getScheduleDetail(String id) {
    throw UnimplementedError();
  }
}

void main() {
  testWidgets('SchedulesPage shows list item', (tester) async {
    final container = ProviderContainer(
      overrides: [
        // Override do usecase provider com GetSchedules usando o DummyRepo
        getSchedulesProvider.overrideWithValue(GetSchedules(DummyScheduleRepository())),
      ],
    );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: SchedulesPage()),
      ),
    );

    // permite o FutureProvider resolver
    await tester.pumpAndSettle();

    // Verificações básicas
    expect(find.byType(ListView), findsOneWidget);
    expect(find.textContaining('Av. Paulista'), findsOneWidget);
  });
}