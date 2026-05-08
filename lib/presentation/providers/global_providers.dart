// lib/presentation/providers/global_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripee_interview/core/utils/pagination.dart';
import 'package:tripee_interview/presentation/providers/schedule_detail_notifier.dart';
import 'package:tripee_interview/presentation/providers/schedules_notifier.dart';
import '../../core/network/dio_client.dart';
import 'package:dio/dio.dart';
import '../../data/datasources/schedule_remote_datasource.dart';
import '../../data/repositories/schedule_repository_impl.dart';
import '../../domain/usecases/get_schedules.dart';
import '../../domain/usecases/get_schedule_detail.dart';
import '../../domain/entities/schedule.dart';
import '../../domain/entities/trip.dart';

final dioProvider = Provider<Dio>((ref) => createDio());

final scheduleRemoteDataSourceProvider = Provider<ScheduleRemoteDataSource>(
  (ref) => ScheduleRemoteDataSourceImpl(ref.read(dioProvider)),
);

final scheduleRepositoryProvider = Provider<ScheduleRepositoryImpl>(
  (ref) => ScheduleRepositoryImpl(ref.read(scheduleRemoteDataSourceProvider)),
);

final getSchedulesProvider = Provider((ref) => GetSchedules(ref.read(scheduleRepositoryProvider)));

final getScheduleDetailProvider =
    Provider((ref) => GetScheduleDetail(ref.read(scheduleRepositoryProvider)));

/// DTO usado como chave para a family provider — permite passar page + filtros
class SchedulesPageRequest {
  final int page;
  final String? query;
  final DateTime? dateFrom;
  final DateTime? dateTo;

  const SchedulesPageRequest({
    required this.page,
    this.query,
    this.dateFrom,
    this.dateTo,
  });
}

/// Provider para requisições pontuais (pode ser usado em telas que só precisam de uma page)
final schedulesPageProvider = FutureProvider.family.autoDispose<PaginatedResult<Schedule>, SchedulesPageRequest>((ref, req) {
  final getSchedules = ref.read(getSchedulesProvider);

  return getSchedules.call(
    page: req.page,
    limit: 15,
    dateFrom: req.dateFrom,
    dateTo: req.dateTo,
    query: req.query, // agora repassando query
  );
});

final scheduleDetailProvider = FutureProvider.family.autoDispose<Trip, String>((ref, id) {
  final getDetail = ref.read(getScheduleDetailProvider);
  return getDetail.call(id);
});

final schedulesNotifierProvider = StateNotifierProvider<SchedulesNotifier, SchedulesState>((ref) {
  final getSchedules = ref.read(getSchedulesProvider);
  return SchedulesNotifier(getSchedules);
});

final scheduleDetailNotifierProvider =
    StateNotifierProvider.autoDispose.family<ScheduleDetailNotifier, ScheduleDetailState, String>(
  (ref, id) {
    final getDetail = ref.read(getScheduleDetailProvider);
    final notifier = ScheduleDetailNotifier(getDetail);
    // carrega automaticamente
    notifier.load(id);
    return notifier;
  },
);