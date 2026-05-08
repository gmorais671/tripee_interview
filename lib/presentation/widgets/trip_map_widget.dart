import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ll;

/// TripMapWidget (ajustado para evitar problema de tiles só aparecerem após toque)
class TripMapWidget extends StatefulWidget {
  final List<dynamic> realizedPoints;
  final List<dynamic> estimatedPoints;
  final dynamic origin;
  final dynamic destination;
  final double height;
  final double initialZoom;
  final double zoomOffset;

  const TripMapWidget({
    super.key,
    this.realizedPoints = const [],
    this.estimatedPoints = const [],
    this.origin,
    this.destination,
    this.height = 260,
    this.initialZoom = 13,
    this.zoomOffset = 0.0,
  });

  @override
  State<TripMapWidget> createState() => _TripMapWidgetState();
}

class _TripMapWidgetState extends State<TripMapWidget> {
  final MapController _mapController = MapController();
  late final StreamSubscription<MapEvent> _mapSub;
  double _currentZoom = 0.0;
  static const double _minMapZoom = 3.0;
  static const double _maxMapZoom = 18.0;

  // Normaliza diversos formatos de ponto para latlong2.LatLng
  ll.LatLng? _toLL(dynamic p) {
    if (p == null) return null;
    try {
      if (p is ll.LatLng) return p;
      final dyn = p as dynamic;
      final lat = dyn.latitude ?? dyn.lat ?? (dyn['latitude'] ?? dyn['lat']);
      final lng = dyn.longitude ?? dyn.lng ?? (dyn['longitude'] ?? dyn['lng']);
      if (lat is num && lng is num) return ll.LatLng(lat.toDouble(), lng.toDouble());
    } catch (_) {
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

    // fallback: centro aproximado do Brasil (ou outro fallback que prefira)
    return const ll.LatLng(-15.7801, -47.9292);
  }

  @override
  void initState() {
    super.initState();

    // inicializa com o initialZoom (até o mapEvent atualizar)
    _currentZoom = widget.initialZoom;

    // escuta eventos do mapa
    _mapSub = _mapController.mapEventStream.listen((event) {
      // tenta pegar zoom do event.camera (presente em MapEvent)
      double z;
      try {
        z = event.camera.zoom;
      } catch (_) {
        // fallback: pega do controller.camera (pode lançar se controller ainda não ligado)
        try {
          z = _mapController.camera.zoom;
        } catch (_) {
          z = _currentZoom;
        }
      }

      // atualiza apenas se houver mudança visível
      if ((z - _currentZoom).abs() > 1e-3) {
        setState(() {
          _currentZoom = z;
        });
      }
    });
  }

  @override
  void dispose() {
    _mapSub.cancel();
    super.dispose();
  }

  double _lerpSizeForZoom({
    required double zoom,
    required double minSize,
    required double maxSize,
    double minZoom = _minMapZoom,
    double maxZoom = _maxMapZoom,
  }) {
    final t = ((zoom - minZoom) / (maxZoom - minZoom)).clamp(0.0, 1.0);
    return minSize + (maxSize - minSize) * t;
  }

  // Versão assíncrona e robusta do fitBounds
  Future<void> _fitBounds() async {
    final all = <ll.LatLng>[];
    all.addAll(_toLLList(widget.realizedPoints));
    all.addAll(_toLLList(widget.estimatedPoints));
    final o = _toLL(widget.origin);
    final d = _toLL(widget.destination);
    if (o != null) all.add(o);
    if (d != null) all.add(d);

    if (all.isEmpty) return;

    // bounding box
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

    final latSpan = (maxLat - minLat).abs();
    final lngSpan = (maxLng - minLng).abs();

    // pega tamanho do widget se disponível
    final size = context.size ?? MediaQuery.of(context).size;
    final mapWidth = math.max(100.0, size.width - 40);
    final mapHeight = math.max(100.0, widget.height - 40);

    double zoomForSpan(double span, double px) {
      if (span <= 0) return widget.initialZoom;
      final z = math.log(px * 360 / (span * 256)) / math.ln2;
      return z;
    }

    final zoomLng = zoomForSpan(lngSpan, mapWidth);
    final zoomLat = zoomForSpan(latSpan, mapHeight);
    double zoom = math.min(zoomLat, zoomLng);

    if (zoom.isNaN || zoom.isInfinite) zoom = widget.initialZoom;
    
    // aplica offset (positivo -> mais perto; negativo -> mais longe)
    zoom = zoom - widget.zoomOffset;

    // garante limites
    zoom = zoom.clamp(3.0, 18.0);

    // Pequeno delay para dar tempo ao TileLayer iniciar
    await Future.delayed(const Duration(milliseconds: 160));

    try {
      _mapController.move(center, zoom);
      // força repaint/pedido de tiles
      if (mounted) setState(() {});
      debugPrint('TripMapWidget: moved to center=$center zoom=$zoom (points=${all.length})');
    } catch (e, st) {
      debugPrint('TripMapWidget._fitBounds error: $e\n$st');
    }
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
    // parâmetros base (ajuste conforme seu gosto)
    const double originMinContainer = 18.0;
    const double originMaxContainer = 40.0;
    const double destMinContainer = 28.0;
    const double destMaxContainer = 72.0;

    // proporção do ícone em relação ao container
    const double originInnerRatio = 0.55; 
    const double destIconRatio = 0.55; 

    final o = _toLL(widget.origin);
    final d = _toLL(widget.destination);

    // ORIGIN marker (círculo azul)
    if (o != null) {
      final originContainer = _lerpSizeForZoom(
        zoom: _currentZoom,
        minSize: originMinContainer,
        maxSize: originMaxContainer,
      );

      final originInner = math.max(6.0, originContainer * originInnerRatio);
      final originBorder = math.max(1.0, originInner * 0.12);

      markers.add(
        Marker(
          point: o,
          width: originContainer,
          height: originContainer,
          child: SizedBox(
            width: originContainer,
            height: originContainer,
            child: Center(
              child: Container(
                width: originInner,
                height: originInner,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: originBorder),
                ),
              ),
            ),
          ),
        ),
      );
    }

    // DESTINATION marker (pin vermelho)
    if (d != null) {
      final destContainer = _lerpSizeForZoom(
        zoom: _currentZoom,
        minSize: destMinContainer,
        maxSize: destMaxContainer,
      );

      final destIconSize = math.max(12.0, destContainer * destIconRatio);

      markers.add(
        Marker(
          point: d,
          width: destContainer,
          height: destContainer,
          child: SizedBox(
            width: destContainer,
            height: destContainer,
            child: Center(
              child: Icon(
                Icons.location_on,
                color: Colors.red,
                size: destIconSize,
              ),
            ),
          ),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
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
                interactionOptions: const InteractionOptions(),
                onMapReady: () {
                  // chama a versão assíncrona
                  _fitBounds();
                },
                keepAlive: false,
              ),
              children: [
                // Use o template único para evitar alerta com subdomains do OSM
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.tripee_interview',
                ),
                if (polylines.isNotEmpty) PolylineLayer(polylines: polylines),
                if (markers.isNotEmpty) MarkerLayer(markers: markers),
              ],
            ),
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