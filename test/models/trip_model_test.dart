import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tripee_interview/data/models/trip_model.dart';
import '../helpers/fixture_reader.dart';

void main() {
  test('TripModel fromJson and toEntity (fixture)', () {
    final raw = fixture('schedule_detail_10.json');
    final Map<String, dynamic> js = json.decode(raw);

    final model = TripModel.fromJson(js);

    // Não verificamos id porque a API de detalhe não retorna id no body
    expect(model.status, js['status']);
    expect(model.start.address, js['start']['address']);
    expect(model.end.address, js['end']['address']);

    // route existe e tem polyline/distance/duration
    expect(model.route, isNotNull);
    expect(model.route?.polyline, js['route']['polyline']);
    expect(model.route?.distance, js['route']['distance']);
    expect(model.route?.duration, js['route']['duration']);

    // driver e provider
    expect(model.driver?.name, js['driver']['name']);
    expect(model.provider?.name, js['provider']['name']);

    // conversão para entity: checar alguns campos básicos
    final entity = model.toEntity();
    expect(entity.status, js['status']);
    expect(entity.start.address, js['start']['address']);
    expect(entity.route?.polyline, js['route']['polyline']);
  });
}