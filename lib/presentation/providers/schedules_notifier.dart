import 'dart:async';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripee_interview/domain/entities/schedule.dart';
import 'package:tripee_interview/domain/usecases/get_schedules.dart';

class SchedulesState {
  final List<Schedule> items;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final int page; // current page loaded (lowestLoadedPage)
  final bool hasMore; // means: has older pages to load (page > 1)
  final int totalPages;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final String? searchQuery;

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
    this.searchQuery,
  });

  static const _noValue = Object();

  SchedulesState copyWith({
    List<Schedule>? items,
    bool? isLoading,
    bool? isLoadingMore,
    Object? error = _noValue, // sentinel to allow explicit null
    int? page,
    bool? hasMore,
    int? totalPages,
    Object? dateFrom = _noValue,
    Object? dateTo = _noValue,
    Object? searchQuery = _noValue,
  }) {
    return SchedulesState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error == _noValue ? this.error : error as String?,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      totalPages: totalPages ?? this.totalPages,
      dateFrom: dateFrom == _noValue ? this.dateFrom : dateFrom as DateTime?,
      dateTo: dateTo == _noValue ? this.dateTo : dateTo as DateTime?,
      searchQuery: searchQuery == _noValue ? this.searchQuery : searchQuery as String?,
    );
  }
}

class SchedulesNotifier extends StateNotifier<SchedulesState> {
  final GetSchedules _getSchedules;
  final int _limit;

  SchedulesNotifier(this._getSchedules, {int limit = 15})
      : _limit = limit,
        super(const SchedulesState());

  // concurrency guard
  bool _loadingInProgress = false;

  // debounce for search
  Timer? _searchDebounce;
  static const _searchDebounceMs = 450;

  // prefetch cap when searching (avoid sweeping all pages)
  static const int _maxPrefetchPagesWhenSearching = 10;

  // helpers
  DateTime _startOfDay(DateTime d) => DateTime(d.year, d.month, d.day, 0, 0, 0);
  DateTime _endOfDay(DateTime d) => DateTime(d.year, d.month, d.day, 23, 59, 59, 999);

  bool _withinRange(DateTime at, DateTime? from, DateTime? to) {
    if (from != null && at.isBefore(from)) return false;
    if (to != null && at.isAfter(to)) return false;
    return true;
  }

  List<Schedule> _filterItemsByDate(List<Schedule> items, DateTime? from, DateTime? to) {
    if (from == null && to == null) return items;
    return items.where((s) {
      final at = s.scheduleAt;
      return at != null && _withinRange(at, from, to);
    }).toList();
  }

  List<Schedule> _filterItemsByQuery(List<Schedule> items, String? query) {
    if (query == null || query.trim().isEmpty) return items;
    final q = query.toLowerCase();
    return items.where((s) {
      final start = s.startAddress?.toLowerCase() ?? '';
      final end = s.endAddress?.toLowerCase() ?? '';
      final status = s.status?.toLowerCase() ?? '';
      final id = s.id?.toString() ?? '';
      return start.contains(q) || end.contains(q) || status.contains(q) || id.contains(q);
    }).toList();
  }

  List<Schedule> _mergeAndDeduplicate(List<Schedule> existing, List<Schedule> additional) {
    final existingIds = existing.map((e) => e.id).toSet();
    final List<Schedule> merged = [...existing];
    for (var s in additional) {
      if (!existingIds.contains(s.id)) {
        merged.add(s);
        existingIds.add(s.id);
      }
    }
    return merged;
  }

  // Public API
  Future<void> loadInitial() async {
    await _loadInitialWithDates(state.dateFrom, state.dateTo, state.searchQuery);
  }

  Future<void> refresh() async {
    await _loadInitialWithDates(state.dateFrom, state.dateTo, state.searchQuery);
  }

  /// apply date range: normalizes, updates state immediately, then reloads
  Future<void> applyDateRange(DateTime? from, DateTime? to) async {
    final DateTime? normalizedFrom = from != null ? _startOfDay(from) : null;
    final DateTime? normalizedTo = to != null ? _endOfDay(to) : null;

    // Update state immediately (allow explicit null)
    state = state.copyWith(
      dateFrom: normalizedFrom,
      dateTo: normalizedTo,
      page: 1,
      items: [],
      isLoading: true,
      isLoadingMore: false,
      error: null,
    );

    await _loadInitialWithDates(normalizedFrom, normalizedTo, state.searchQuery);
  }

  /// Executa a busca imediatamente (cancela debounce, atualiza state e carrega)
  Future<void> searchNow(String? rawQuery) async {
    _searchDebounce?.cancel();
    final query = (rawQuery == null || rawQuery.trim().isEmpty) ? null : rawQuery.trim();

    // atualiza searchQuery no estado imediatamente
    state = state.copyWith(searchQuery: query, isLoading: true, isLoadingMore: false);

    // chama a rotina de load que usará o query passado
    await _loadInitialWithDates(state.dateFrom, state.dateTo, query);
  }

  /// applySearch: called by UI when user types. Debounced to avoid many requests.
  void applySearch(String? rawQuery) {
    final query = (rawQuery == null || rawQuery.trim().isEmpty) ? null : rawQuery.trim();

    // cancela debounce anterior
    _searchDebounce?.cancel();

    // atualiza apenas o campo de query no state (mantém items até a busca acontecer)
    state = state.copyWith(searchQuery: query);

    // se o usuário limpou o campo, executa a busca imediatamente (sem debounce)
    if (query == null) {
      // chama a busca imediata (não await aqui para não bloquear o UI sync)
      searchNow(null);
      return;
    }

    // agenda a busca debounced
    _searchDebounce = Timer(Duration(milliseconds: _searchDebounceMs), () async {
      // no momento que o debounce dispara, podemos mostrar loading/limpar items se quiser.
      // aqui decidimos setar isLoading = true para indicar que estamos recarregando.
      state = state.copyWith(isLoading: true, isLoadingMore: false);
      await _loadInitialWithDates(state.dateFrom, state.dateTo, query);
    });
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  // Core: load initial pages (reverse pagination: last page first)
  Future<void> _loadInitialWithDates(DateTime? dateFrom, DateTime? dateTo, [String? searchQuery]) async {
    if (_loadingInProgress) return;
    _loadingInProgress = true;

    try {
      // mark loading in state
      state = state.copyWith(isLoading: true, error: null);

      // 1) fetch page=1 to discover totalPages
      final firstPageResult = await _getSchedules.call(
        page: 1,
        limit: _limit,
        dateFrom: dateFrom,
        dateTo: dateTo,
        query: searchQuery,
      );

      final int totalPages = math.max(1, firstPageResult.totalPages ?? 1);

      // 2) fetch last page (most recent)
      var lastPage = totalPages;
      final lastPageResult = await _getSchedules.call(
        page: lastPage,
        limit: _limit,
        dateFrom: dateFrom,
        dateTo: dateTo,
        query: searchQuery,
      );

      // local fallback filtering
      List<Schedule> accumulated = _filterItemsByDate(lastPageResult.items, dateFrom, dateTo);
      accumulated = _filterItemsByQuery(accumulated, searchQuery);

      var lowestLoadedPage = lastPage;
      int prefetchCount = 0;

      // If there's a searchQuery (server might ignore), prefetch older pages until
      // we have at least _limit items or we hit page 1 or reach prefetch cap.
      while ((searchQuery != null && searchQuery.trim().isNotEmpty) &&
          accumulated.length < _limit &&
          lowestLoadedPage > 1 &&
          prefetchCount < _maxPrefetchPagesWhenSearching) {
        final nextPage = lowestLoadedPage - 1;
        final pageResult = await _getSchedules.call(
          page: nextPage,
          limit: _limit,
          dateFrom: dateFrom,
          dateTo: dateTo,
          query: searchQuery,
        );

        final pageFiltered = _filterItemsByDate(pageResult.items, dateFrom, dateTo);
        final pageFilteredWithQuery = _filterItemsByQuery(pageFiltered, searchQuery);

        // append older pages at the end (keeps descending recency order)
        accumulated = [...accumulated, ...pageFilteredWithQuery];

        lowestLoadedPage = nextPage;
        prefetchCount += 1;
        if (lowestLoadedPage <= 1) break;
      }

      final hasMore = lowestLoadedPage > 1;

      state = state.copyWith(
        items: accumulated,
        isLoading: false,
        isLoadingMore: false,
        page: lowestLoadedPage,
        hasMore: hasMore,
        totalPages: totalPages,
        dateFrom: dateFrom,
        dateTo: dateTo,
        searchQuery: searchQuery,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, isLoadingMore: false, error: e.toString());
      rethrow;
    } finally {
      _loadingInProgress = false;
    }
  }

  // load more (decrement page)
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    final prevPage = state.page - 1;
    if (prevPage < 1) {
      state = state.copyWith(hasMore: false);
      return;
    }

    state = state.copyWith(isLoadingMore: true, error: null);
    try {
      final result = await _getSchedules.call(
        page: prevPage,
        limit: _limit,
        dateFrom: state.dateFrom,
        dateTo: state.dateTo,
        query: state.searchQuery,
      );

      final filtered = _filterItemsByDate(result.items, state.dateFrom, state.dateTo);
      final filteredWithQuery = _filterItemsByQuery(filtered, state.searchQuery);

      final newItems = _mergeAndDeduplicate(state.items, filteredWithQuery);
      final hasMore = prevPage > 1;

      state = state.copyWith(
        items: newItems,
        isLoadingMore: false,
        page: prevPage,
        hasMore: hasMore,
        totalPages: result.totalPages,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }
}