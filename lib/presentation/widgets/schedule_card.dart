// lib/presentation/widgets/schedule_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/schedule.dart';

class ScheduleCard extends StatelessWidget {
  final Schedule schedule;
  const ScheduleCard({Key? key, required this.schedule}) : super(key: key);

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
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

  String _formattedTime(DateTime dt) {
    return DateFormat.Hm().format(dt.toLocal()); // 24h HH:mm
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(schedule.status);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time column
            Column(
              children: [
                Text(
                  _formattedTime(schedule.scheduleAt),
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
                    schedule.startAddress,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    schedule.endAddress,
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
                    schedule.status[0].toUpperCase() + schedule.status.substring(1),
                    style: TextStyle(color: statusColor, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}