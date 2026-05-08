import 'package:dio/dio.dart';
import '../../core/utils/pagination.dart';
import '../models/schedule_model.dart';
import '../models/trip_model.dart';

abstract class ScheduleRemoteDataSource {
  Future<PaginatedResult<ScheduleModel>> getSchedules({
    int page = 1,
    int limit = 15,
    DateTime? dateFrom,
    DateTime? dateTo,
    String? query, // novo
  });
  Future<TripModel> getScheduleDetail(String id);
}

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  final Dio dio;
  ScheduleRemoteDataSourceImpl(this.dio);

  @override
  Future<PaginatedResult<ScheduleModel>> getSchedules({
    int page = 1,
    int limit = 15,
    DateTime? dateFrom,
    DateTime? dateTo,
    String? query,
  }) async {
    final params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };

    // envia sempre no formato ISO-8601 UTC (se definido)
    if (dateFrom != null) params['date_from'] = dateFrom.toUtc().toIso8601String();
    if (dateTo != null) params['date_to'] = dateTo.toUtc().toIso8601String();

    if (query != null && query.isNotEmpty) {
      params['query'] = query;
    }

    final resp = await dio.get('/schedules', queryParameters: params);
    final data = resp.data as Map<String, dynamic>;
    final list = (data['data'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>();
    final items = list.map((json) => ScheduleModel.fromJson(json)).toList();

    final total = data['total'] is int
        ? data['total'] as int
        : (data['total'] != null ? int.tryParse(data['total'].toString()) ?? (page - 1) * limit + items.length : (page - 1) * limit + items.length);

    final totalPages = data['total_pages'] is int
        ? data['total_pages'] as int
        : ((total + limit - 1) ~/ limit);

    final respPage = data['page'] is int ? data['page'] as int : page;
    final respLimit = data['limit'] is int ? data['limit'] as int : limit;

    return PaginatedResult<ScheduleModel>(
      items: items,
      page: respPage,
      limit: respLimit,
      total: total,
      totalPages: totalPages,
    );
  }

  @override
  Future<TripModel> getScheduleDetail(String id) async {
    final resp = await dio.get('/schedules/$id');
    final json = resp.data as Map<String, dynamic>;
    return TripModel.fromJson(json);
  }
}