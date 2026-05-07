import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tripee_interview/data/datasources/schedule_remote_datasource.dart';
import '../helpers/fixture_reader.dart';

class MockDio extends Mock implements Dio {}
class FakeRequestOptions extends Fake implements RequestOptions {}

void main() {
  late MockDio mockDio;
  late ScheduleRemoteDataSourceImpl datasource;

  setUpAll(() {
    registerFallbackValue(FakeRequestOptions());
  });

  setUp(() {
    mockDio = MockDio();
    datasource = ScheduleRemoteDataSourceImpl(mockDio);
  });

  test('getSchedules returns list of ScheduleModel (from fixture)', () async {
    final raw = fixture('schedules_page_1.json');
    final parsed = json.decode(raw);

    when(() => mockDio.get(
      '/schedules',
      queryParameters: any(named: 'queryParameters'),
    )).thenAnswer((_) async => Response(
      requestOptions: RequestOptions(path: '/schedules'),
      data: parsed,
      statusCode: 200,
    ));

    final list = await datasource.getSchedules(page: 1, limit: 15);
    expect(list, isNotEmpty);
    expect(list.first.id, parsed['data'][0]['id'] as String);

    verify(() => mockDio.get('/schedules', queryParameters: {'page': 1, 'limit': 15})).called(1);
  });

  test('getScheduleDetail returns TripModel (from fixture)', () async {
    final raw = fixture('schedule_detail_10.json');
    final parsed = json.decode(raw);

    when(() => mockDio.get('/schedules/10')).thenAnswer((_) async => Response(
      requestOptions: RequestOptions(path: '/schedules/10'),
      data: parsed,
      statusCode: 200,
    ));

    final model = await datasource.getScheduleDetail('10');
    expect(model.status, parsed['status']);
    expect(model.start.address, parsed['start']['address']);
    verify(() => mockDio.get('/schedules/10')).called(1);
  });
}