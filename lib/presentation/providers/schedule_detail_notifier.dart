// lib/presentation/providers/schedule_detail_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tripee_interview/core/utils/polyline_decoder.dart';
import '../../domain/entities/trip.dart';
import '../../domain/usecases/get_schedule_detail.dart';

class ScheduleDetailState {
  final bool loading;
  final Trip? trip;
  final String? error;
  final List<LatLng> realizedPoints;
  final List<LatLng> estimatedPoints;

  const ScheduleDetailState({
    this.loading = false,
    this.trip,
    this.error,
    this.realizedPoints = const [],
    this.estimatedPoints = const [],
  });

  ScheduleDetailState copyWith({
    bool? loading,
    Trip? trip,
    String? error,
    List<LatLng>? realizedPoints,
    List<LatLng>? estimatedPoints,
  }) {
    return ScheduleDetailState(
      loading: loading ?? this.loading,
      trip: trip ?? this.trip,
      error: error,
      realizedPoints: realizedPoints ?? this.realizedPoints,
      estimatedPoints: estimatedPoints ?? this.estimatedPoints,
    );
  }
}

class ScheduleDetailNotifier extends StateNotifier<ScheduleDetailState> {
  final GetScheduleDetail _getDetail;

  // guarda o último id solicitado
  String? _lastId;

  ScheduleDetailNotifier(this._getDetail) : super(const ScheduleDetailState());

  Future<void> load(String id) async {
    
    if (state.loading) return;

    _lastId = id; 
    state = state.copyWith(loading: true, error: null);

    try {
      final trip = await _getDetail.call(id);

      final realized = decodePolyline(trip.route?.polyline);
      final estimated = decodePolyline(trip.estimateRoute?.polyline);

      state = state.copyWith(
        loading: false,
        trip: trip,
        error: null,
        realizedPoints: realized,
        estimatedPoints: estimated,
      );
    } catch (e, st) {
      // opcional: log em dev
      print('ScheduleDetail.load error: $e\n$st');

      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    final id = _lastId;
    if (id == null) return;
    await load(id);
  }
}