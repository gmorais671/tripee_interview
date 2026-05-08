import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ll;

/// TripMapWidget
/// - realizedPoints / estimatedPoints: lista de pontos. Aceita:
///   - latlong2.LatLng
///   - objetos com propriedades `latitude` e `longitude` (ex: google_maps_flutter.LatLng)
///   - Map com chaves 'lat'/'lng' ou 'latitude'/'longitude'
/// - origin/destination: mesmo formato acima (opcional)
class TripMapWidget extends StatefulWidget {
  final List<dynamic> realizedPoints;
  final List<dynamic> estimatedPoints;
  final dynamic origin;
  final dynamic destination;
  final double height;
  final double initialZoom;

  const TripMapWidget({
    super.key,
    this.realizedPoints = const [],
    this.estimatedPoints = const [],
    this.origin,
    this.destination,
    this.height = 260,
    this.initialZoom = 13,
  });

  @override
  State<TripMapWidget> createState() => _TripMapWidgetState();
}

class _TripMapWidgetState extends State<TripMapWidget> {
  final MapController _mapController = MapController();

  // Normaliza diversos formatos de ponto para latlong2.LatLng
  ll.LatLng? _toLL(dynamic p) {
    if (p == null) return null;
    try {
      if (p is ll.LatLng) return p;
      // google_maps_flutter.LatLng has latitude and longitude getters
      final dyn = p as dynamic;
      final lat = dyn.latitude ?? dyn.lat ?? (dyn['latitude'] ?? dyn['lat']);
      final lng = dyn.longitude ?? dyn.lng ?? (dyn['longitude'] ?? dyn['lng']);
      if (lat is num && lng is num) return ll.LatLng(lat.toDouble(), lng.toDouble());
    } catch (_) {
      // fallback para Map-like
      try {
        if (p is Map) {
          final lat = p['latitude'] ?? p['lat'];
          final lng = p['longitude'] ?? p['lng'];
          if (lat is num && lng is num) return ll.LatLng(lat.toDouble(), lng.toDouble());
        }
      } catch (_) {}
    }
    return null;
  }

  List<ll.LatLng> _toLLList(List<dynamic>? list) {
    if (list == null) return [];
    final out = <ll.LatLng>[];
    for (final e in list) {
      final v = _toLL(e);
      if (v != null) out.add(v);
    }
    return out;
  }

  ll.LatLng _initialCenter() {
    final o = _toLL(widget.origin);
    if (o != null) return o;
    final r = _toLLList(widget.realizedPoints);
    if (r.isNotEmpty) return r.first;
    final e = _toLLList(widget.estimatedPoints);
    if (e.isNotEmpty) return e.first;

    // fallback: centro aproximado do Brasil (ou escolha outra)
    return const ll.LatLng(-15.7801, -47.9292);
  }

  @override
  void initState() {
    super.initState();
    // Ajusta bounds após o build
    WidgetsBinding.instance.addPostFrameCallback((_) => _fitBounds());
  }

  void _fitBounds() {
    final all = <ll.LatLng>[];
    all.addAll(_toLLList(widget.realizedPoints));
    all.addAll(_toLLList(widget.estimatedPoints));
    final o = _toLL(widget.origin);
    final d = _toLL(widget.destination);
    if (o != null) all.add(o);
    if (d != null) all.add(d);

    if (all.isEmpty) return;

    double minLat = all.first.latitude;
    double maxLat = all.first.latitude;
    double minLng = all.first.longitude;
    double maxLng = all.first.longitude;

    for (final p in all) {
      if (p.latitude < minLat) minLat = p.latitude;
      if (p.latitude > maxLat) maxLat = p.latitude;
      if (p.longitude < minLng) minLng = p.longitude;
      if (p.longitude > maxLng) maxLng = p.longitude;
    }

    final centerLat = (minLat + maxLat) / 2;
    final centerLng = (minLng + maxLng) / 2;
    final center = ll.LatLng(centerLat, centerLng);

    // estimate zoom to fit longitude/latitude span into widget size
    final latSpan = (maxLat - minLat).abs();
    final lngSpan = (maxLng - minLng).abs();

    // get map widget size (fallback to MediaQuery)
    final size = context.size ?? MediaQuery.of(context).size;
    final mapWidth = size.width - 40; // deixa um padding visual
    final mapHeight = widget.height - 40;

    double zoomForSpan(double span, double px) {
      if (span <= 0) return widget.initialZoom;
      // formula aproximada para zoom (tile size = 256)
      final z = math.log(px * 360 / (span * 256)) / math.ln2;
      return z;
    }

    final zoomLng = zoomForSpan(lngSpan, mapWidth);
    final zoomLat = zoomForSpan(latSpan, mapHeight);

    // escolhe o menor zoom (mais distante) entre os dois para garantir que todo o bounds caiba
    double zoom = math.min(zoomLat, zoomLng);

    // some sane bounds: 1..18 (ajuste conforme necessário)
    if (zoom.isNaN || zoom.isInfinite) zoom = widget.initialZoom;
    zoom = zoom.clamp(3.0, 18.0);

    // move camera para o centro com o zoom calculado
    _mapController.move(center, zoom);
  }

  Widget _legend() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _legendItem('Realizado', const Color(0xFF1976D2)),
          const SizedBox(width: 10),
          _legendItem('Estimado', Colors.orange),
        ],
      ),
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(width: 20, height: 4, color: color),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final realized = _toLLList(widget.realizedPoints);
    final estimated = _toLLList(widget.estimatedPoints);

    final polylines = <Polyline>[];
    if (realized.isNotEmpty) {
      polylines.add(Polyline(points: realized, color: const Color(0xFF1976D2), strokeWidth: 4.0));
    }
    if (estimated.isNotEmpty) {
      polylines.add(Polyline(points: estimated, color: Colors.orange, strokeWidth: 3.0));
    }

    final markers = <Marker>[];
    final o = _toLL(widget.origin);
    final d = _toLL(widget.destination);
    if (o != null) {
      markers.add(
        Marker(
          point: o,
          width: 36,
          height: 36,
          child: const Icon(Icons.circle, color: Colors.blue, size: 12),
        )
      );
    }
    if (d != null) {
      markers.add(
        Marker(
          point: d,
          width: 36,
          height: 36,
          child: const Icon(Icons.location_on, color: Colors.red, size: 28),
        )
      );
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: SizedBox(
        height: widget.height,
        child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _initialCenter(),
                initialZoom: widget.initialZoom,
                // configuração de interação (use const para padrão)
                interactionOptions: const InteractionOptions(),
                // callback quando o mapa estiver pronto (bom para ajustar bounds)
                onMapReady: () => _fitBounds(),
                keepAlive: false,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.tripee_interview',
                ),
                if (polylines.isNotEmpty) PolylineLayer(polylines: polylines),
                if (markers.isNotEmpty) MarkerLayer(markers: markers),
              ],
            ),
            // legenda flutuante
            Positioned(
              right: 12,
              bottom: 12,
              child: _legend(),
            ),
          ],
        ),
      ),
    );
  }
}