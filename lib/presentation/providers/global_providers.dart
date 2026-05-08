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

final schedulesPageProvider = FutureProvider.family.autoDispose<PaginatedResult<Schedule>, int>((ref, page) {
  final getSchedules = ref.read(getSchedulesProvider);
  
  return getSchedules.call(page: page, limit: 15);
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
    // carrega automáticamente
    notifier.load(id);
    return notifier;
  },
);