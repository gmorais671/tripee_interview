// lib/presentation/widgets/schedule_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripee_interview/presentation/pages/schedule_detail_page.dart';
import '../../domain/entities/schedule.dart';

class ScheduleCard extends StatelessWidget {
  final Schedule schedule;
  const ScheduleCard({Key? key, required this.schedule}) : super(key: key);

  Color _statusColor(String? status) {
    final s = (status ?? '').toLowerCase();
    switch (s) {
      case 'completed':
      case 'realized':
      case 'realizada':
        return Colors.green;
      case 'cancelled':
      case 'canceled':
        return Colors.red;
      case 'in_progress':
        return Colors.blue;
      case 'confirmed':
        return Colors.teal;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formattedTime(DateTime? dt) {
    if (dt == null) return '—';
    try {
      return DateFormat.Hm().format(dt.toLocal()); // 24h HH:mm
    } catch (_) {
      return '—';
    }
  }

  String _capitalized(String? s) {
    if (s == null || s.isEmpty) return '—';
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final status = schedule.status;
    final statusColor = _statusColor(status);
    final startAddress = schedule.startAddress ?? '—';
    final endAddress = schedule.endAddress ?? '—';
    final scheduleAt = schedule.scheduleAt; // supondo DateTime? no seu model

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          final id = schedule.id;
          if (id == null || id.isEmpty) return; // evita navegar sem id
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScheduleDetailPage(scheduleId: id),
            ),
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time column
              Column(
                children: [
                  Text(
                    _formattedTime(scheduleAt),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              // Address column (expanded)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      startAddress,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      endAddress,
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Status text
              const SizedBox(width: 8),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: statusColor.withOpacity(0.2)),
                    ),
                    child: Text(
                      _capitalized(status),
                      style: TextStyle(color: statusColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}