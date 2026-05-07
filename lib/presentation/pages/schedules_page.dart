import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/schedule.dart';
import '../widgets/schedule_card.dart';

class SchedulesPage extends StatelessWidget {
  const SchedulesPage({Key? key}) : super(key: key);

  // Exemplo estático (substituir depois pelo provider)
  List<Schedule> _sampleSchedules() {
    return [
      Schedule(
        id: '1',
        scheduleAt: DateTime.parse('2026-05-01T08:00:00.000Z'),
        startAddress: 'Av. Paulista, 1000 — Bela Vista',
        endAddress: 'Rua Oscar Freire, 300 — Jardins',
        status: 'confirmed',
      ),
      Schedule(
        id: '2',
        scheduleAt: DateTime.parse('2026-05-01T09:30:00.000Z'),
        startAddress: 'Rua Augusta, 450 — Consolação',
        endAddress: 'Praça da Sé, s/n — Sé',
        status: 'completed',
      ),
      Schedule(
        id: '3',
        scheduleAt: DateTime.parse('2026-05-02T07:15:00.000Z'),
        startAddress: 'Rua da Consolação, 2000 — Consolação',
        endAddress: 'Av. Brigadeiro, 1200 — Jardim Paulista',
        status: 'pending',
      ),
    ];
  }

  String _headerSubtitle() {
    final now = DateTime.now();
    return DateFormat.yMMMMd().format(now);
  }

  @override
  Widget build(BuildContext context) {
    final schedules = _sampleSchedules();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Histórico'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: Column(
        children: [
          // Top controls: period dropdown + search (static for now)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {}, // **static** for now
                  icon: const Icon(Icons.date_range_outlined),
                  label: const Text('Período'),
                  style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: Colors.grey[200], foregroundColor: Colors.black87),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Buscar',
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Subtitle (ex: Hoje · 25 Nov, 2024)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                Text('Hoje · ${_headerSubtitle()}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800])),
              ],
            ),
          ),

          // List
          Expanded(
            child: ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                final s = schedules[index];
                return ScheduleCard(schedule: s);
              },
            ),
          ),
        ],
      ),
    );
  }
}