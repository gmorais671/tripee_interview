import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripee_interview/domain/entities/schedule.dart';
import 'package:tripee_interview/domain/usecases/get_schedules.dart';
import '../../core/utils/pagination.dart';

class SchedulesState {
  final List<Schedule> items;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final int page;
  final bool hasMore;
  final int totalPages;
  final DateTime? dateFrom;
  final DateTime? dateTo;

  const SchedulesState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
    this.page = 1,
    this.hasMore = true,
    this.totalPages = 1,
    this.dateFrom,
    this.dateTo,
  });

  SchedulesState copyWith({
    List<Schedule>? items,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
    int? page,
    bool? hasMore,
    int? totalPages,
    DateTime? dateFrom,
    DateTime? dateTo,
  }) {
    return SchedulesState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      totalPages: totalPages ?? this.totalPages,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
    );
  }
}

class SchedulesNotifier extends StateNotifier<SchedulesState> {
  final GetSchedules _getSchedules;
  final int _limit;

  SchedulesNotifier(this._getSchedules, {int limit = 15})
      : _limit = limit,
        super(const SchedulesState());

  bool _withinRange(DateTime at, DateTime? from, DateTime? to) {
    if (from != null && at.isBefore(from)) return false;
    if (to != null && at.isAfter(to)) return false;
    return true;
  }

  // Converte e filtra a lista retornada pelo servidor usando dateFrom/dateTo
  List<Schedule> _filterItemsByDate(List<Schedule> items, DateTime? from, DateTime? to) {
    if (from == null && to == null) return items;
    return items.where((s) {
      final at = s.scheduleAt; // supondo que Schedule.scheduleAt é DateTime
      return _withinRange(at, from, to);
    }).toList();
  }

  Future<void> loadInitial() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, error: null, page: 1);
    try {
      final result = await _getSchedules.call(
        page: 1,
        limit: _limit,
        dateFrom: state.dateFrom,
        dateTo: state.dateTo,
      );

      // Filtragem cliente — caso o backend não aplique o filtro
      final filtered = _filterItemsByDate(result.items, state.dateFrom, state.dateTo);

      final hasMore = result.page < result.totalPages; // ainda tentamos varrer até totalPages
      state = state.copyWith(
        items: filtered,
        isLoading: false,
        page: result.page,
        hasMore: hasMore,
        totalPages: result.totalPages,
      );
    } catch (e, st) {
      state = state.copyWith(isLoading: false, error: e.toString());
      print('loadInitial error: $e\n$st');
    }
  }

  Future<void> refresh() async {
    await loadInitial();
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    final nextPage = state.page + 1;
    if (nextPage > state.totalPages) {
      state = state.copyWith(hasMore: false);
      return;
    }

    state = state.copyWith(isLoadingMore: true, error: null);
    try {
      final result = await _getSchedules.call(
        page: nextPage,
        limit: _limit,
        dateFrom: state.dateFrom,
        dateTo: state.dateTo,
      );

      // filtrar somente os itens do intervalo
      final filtered = _filterItemsByDate(result.items, state.dateFrom, state.dateTo);

      final newItems = [...state.items, ...filtered];
      final hasMore = result.page < result.totalPages;
      state = state.copyWith(
        items: newItems,
        isLoadingMore: false,
        page: result.page,
        hasMore: hasMore,
        totalPages: result.totalPages,
      );
    } catch (e, st) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
      print('loadMore error: $e\n$st');
    }
  }

  Future<void> applyDateRange(DateTime? from, DateTime? to) async {
    // resetar estado e paginação
    state = state.copyWith(dateFrom: from, dateTo: to, page: 1, items: [], totalPages: 1, hasMore: true);
    await loadInitial();
  }
}