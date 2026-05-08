// lib/presentation/pages/schedule_detail_page.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:tripee_interview/domain/entities/trip.dart';
import 'package:tripee_interview/presentation/widgets/driver_avatar.dart';
import 'package:tripee_interview/presentation/widgets/router_points.dart';
import 'package:tripee_interview/presentation/widgets/trip_map_widget.dart';
import '../providers/global_providers.dart';

class ScheduleDetailPage extends ConsumerWidget {
  final String scheduleId;
  const ScheduleDetailPage({super.key, required this.scheduleId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduleDetailNotifierProvider(scheduleId));

    if (state.loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (state.error != null) {
      return Scaffold(appBar: _buildAppBar(), body: Center(child: Text('Erro: ${state.error}')));
    }
    final trip = state.trip;
    if (trip == null) {
      return Scaffold(appBar: _buildAppBar(), body: const Center(child: Text('Detalhes não encontrados')));
    }

    // null-safe values
    final providerName = trip.provider?.name ?? '—';
    final driverName = trip.driver?.name ?? '—';
    final driverCar = trip.driver?.car ?? '—';
    final driverPlate = trip.driver?.plate ?? '—';
    final status = trip.status ?? '—';
    final startAddress = trip.start?.address ?? '—';
    final endAddress = trip.end?.address ?? '—';

    final ImageProvider? driverImage = (trip.driver?.photo != null && trip.driver!.photo!.isNotEmpty)
        ? NetworkImage(trip.driver!.photo!)
        : null;

    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // Mapa: usa TripMapWidget se tivermos coordenadas; senão mostra o placeholder cinza
            if (trip.start?.coordinates != null && trip.end?.coordinates != null) ...[
              TripMapWidget(
                realizedPoints: state.realizedPoints,
                estimatedPoints: state.estimatedPoints,
                origin: LatLng(trip.start!.coordinates!.lat!, trip.start!.coordinates!.lng!),
                destination: LatLng(trip.end!.coordinates!.lat!, trip.end!.coordinates!.lng!),
                height: 260,
                zoomOffset: 0.7,
              ),
            ] else ...[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.grey[100],
                  child: const Center(child: Icon(Icons.map_outlined, size: 48)),
                ),
              ),
            ],

            const SizedBox(height: 12),

            // Status
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(color: Colors.green[100], borderRadius: BorderRadius.circular(6)),
                child: Text(status, style: const TextStyle(color: Color.fromARGB(255, 14, 90, 26))),
              ),
            ),

            const SizedBox(height: 12),

            // Origem
            RoutePoints(
              originTitle: 'Origem - ${_formatDate(trip.startDate)}',
              originSubtitle: startAddress,
              destinationTitle: 'Destino - ${_formatDate(trip.endDate)}',
              destinationSubtitle: endAddress,
              accentColor: const Color(0xFF1976D2), // opcional, padrão usa theme
            ),

            const Divider(),

            // Driver
            ListTile(
              leading: DriverAvatar(
                driverPhotoUrl: trip.driver?.photo,
                providerLogoUrl: trip.provider?.logo,
                driverName: trip.driver?.name,
                radius: 28,
              ),
              title: Text(trip.driver?.name ?? 'Motorista não identificado'),
              subtitle: Text(
                '${trip.provider?.name} | ${trip.driver?.car} • ${trip.driver?.plate}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            const Divider(),

            _buildPoliciesAndRating(trip),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => ref.read(scheduleDetailNotifierProvider(scheduleId).notifier).refresh(),
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: const Text('Detalhes da corrida', style: TextStyle(color: Colors.black87)),
      centerTitle: true,
    );
  }

  String _formatDate(DateTime? dt) {
    if (dt == null) return '—';
    return '${dt.day} ${_monthAbbr(dt.month)}, ${dt.year} • ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  String _monthAbbr(int m) {
    const months = ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'];
    return months[m - 1];
  }

  String getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  Widget _buildPoliciesAndRating(Trip trip) {

    // Dados defensivos
    const String justificationLabel = 'Justificativa';
    const String justificationValue = 'Fornecedor';

    const int rating = 4; // fixa 4 estrelas por enquanto
    const String comment = 'Motorista muito educado, seguiu o caminho corretamente!';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (opcional: já tem driver acima — mantenha ou remova)
          // Políticas
          const SizedBox(height: 8),
          const Text(
            'Políticas de solicitação',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          // Justificativa
          const Text(
            justificationLabel,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          const Text(
            justificationValue,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),

          const SizedBox(height: 18),
          const Divider(height: 8),
          const SizedBox(height: 18),

          // Avaliação
          const Text(
            'Avaliação',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(5, (index) {
              final filled = index < rating;
              return Icon(
                filled ? Icons.star : Icons.star_border,
                color: const Color(0xFF1976D2),
                size: 26,
              );
            }),
          ),
          const SizedBox(height: 12),
          // Comentário (em aspas, itálico)
          const Text(
            comment == '—' ? 'Sem avaliação' : '“$comment”',
            style: TextStyle(
              color: Colors.black,
              fontStyle: comment == '—' ? FontStyle.normal : FontStyle.italic,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}