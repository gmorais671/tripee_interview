// lib/presentation/widgets/schedule_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripee_interview/presentation/pages/schedule_detail_page.dart';
import 'package:tripee_interview/presentation/widgets/route_points.dart';
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
      case 'realizado':
        return Colors.green;
      case 'cancelled':
      case 'canceled':
      case 'cancelada':
        return Colors.red;
      case 'in_progress':
      case 'inprogress':
      case 'in-progress':
        return Colors.blue;
      case 'confirmed':
        return Colors.teal;
      case 'pending':
      case 'pendente':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _statusLabel(String? status) {
    if (status == null || status.isEmpty) return '—';
    final s = status.toLowerCase().replaceAll('-', '_').trim();
    final map = {
      'in_progress': 'Em andamento',
      'inprogress': 'Em andamento',
      'in-progress': 'Em andamento',
      'completed': 'Realizada',
      'realized': 'Realizada',
      'realizada': 'Realizada',
      'realizado': 'Realizada',
      'cancelled': 'Cancelada',
      'canceled': 'Cancelada',
      'pending': 'Pendente',
      'confirmed': 'Confirmado',
    };

    String humanize(String raw) {
      final parts = raw.replaceAll('_', ' ').split(' ').where((p) => p.isNotEmpty).toList();
      return parts.map((p) => p[0].toUpperCase() + (p.length > 1 ? p.substring(1) : '')).join(' ');
    }

    return map[s] ?? humanize(s);
  }

  String _formattedTime(DateTime? dt) {
    if (dt == null) return '—';
    try {
      return DateFormat.Hm().format(dt.toLocal()); // HH:mm 24h
    } catch (_) {
      return '—';
    }
  }

  // Se a API retorna "Rua X — Bairro", separa em title/subtitle.
  String _titleFromAddress(String address) {
    final parts = address.split(' — ');
    return parts.isNotEmpty ? parts[0] : address;
  }

  String _subtitleFromAddress(String address) {
    final parts = address.split(' — ');
    return parts.length > 1 ? parts.sublist(1).join(' — ') : '';
  }

  @override
  Widget build(BuildContext context) {
    final status = schedule.status;
    final statusColor = _statusColor(status);
    final startAddress = schedule.startAddress ?? '—';
    final endAddress = schedule.endAddress ?? '—';
    final scheduleAt = schedule.scheduleAt;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      child: InkWell(
        onTap: () {
          final id = schedule.id;
          if (id == null || id.isEmpty) return;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ScheduleDetailPage(scheduleId: id)),
          );
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Hora no topo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  _formattedTime(scheduleAt),
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ),

              const SizedBox(height: 2), // espaço reduzido entre hora e conteúdo

              // Row com RoutePoints (expand) e Status (pill)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RoutePoints(
                      originTitle: _titleFromAddress(startAddress),
                      originSubtitle: _subtitleFromAddress(startAddress),
                      destinationTitle: _titleFromAddress(endAddress),
                      destinationSubtitle: _subtitleFromAddress(endAddress),
                      accentColor: const Color(0xFF1976D2),
                      iconScale: 0.78,
                      iconColumnWidth: 36,
                      showConnector: false,
                      connectorSpacing: 10,
                      lineHeight: 10,
                      lineDashHeight: 1,
                      lineGap: 2,
                      lineStrokeWidth: 1,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      showSubtitle: false,
                    ),
                  ),

                  // Status pill (vertical center)
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 4, 6, 4),
                    child: Text(
                      _statusLabel(status),
                      style: TextStyle(color: statusColor, fontWeight: FontWeight.w700, fontSize: 14),
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