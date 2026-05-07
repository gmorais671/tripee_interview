import 'package:dio/dio.dart';
import '../models/schedule_model.dart';
import '../models/trip_model.dart';

abstract class ScheduleRemoteDataSource {
  Future<List<ScheduleModel>> getSchedules({int page = 1, int limit = 15});
  Future<TripModel> getScheduleDetail(String id);
}

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  final Dio dio;
  ScheduleRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ScheduleModel>> getSchedules({int page = 1, int limit = 15}) async {
    final resp = await dio.get('/schedules', queryParameters: {'page': page, 'limit': limit});
    final data = resp.data as Map<String, dynamic>;
    final list = (data['data'] as List).cast<Map<String, dynamic>>();
    return list.map((json) => ScheduleModel.fromJson(json)).toList();
  }

  @override
  Future<TripModel> getScheduleDetail(String id) async {
    final resp = await dio.get('/schedules/$id');
    final json = resp.data as Map<String, dynamic>;
    return TripModel.fromJson(json);
  }
}