import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tripee_interview/data/models/schedule_model.dart';

void main() {
  test('ScheduleModel fromJson and toEntity', () {
    const jsonString = '''
    {
      "schedule_at": "2026-05-01T08:00:00.000Z",
      "start_address": "Av. Paulista, 1000 — Bela Vista",
      "end_address": "Rua Oscar Freire, 300 — Jardins",
      "status": "confirmed",
      "id": "1"
    }
    ''';

    final Map<String, dynamic> js = json.decode(jsonString);
    final model = ScheduleModel.fromJson(js);

    expect(model.id, '1');
    expect(model.status, 'confirmed');
    expect(model.startAddress, contains('Av. Paulista'));

    final entity = model.toEntity();
    expect(entity.id, '1');
    expect(entity.startAddress, model.startAddress);
  });
}