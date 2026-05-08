// providers/schedules_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripee_interview/domain/entities/schedule.dart';
import 'package:tripee_interview/domain/usecases/get_schedules.dart';
import 'dart:math' as math;

class SchedulesState {
  final List<Schedule> items;
  final bool isLoading;
  final bool isLoadingMore;
  final String? error;
  final int page; // current page loaded (starts at lastPage)
  final bool hasMore; // means: has older pages to load (page > 1)
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

  static const _noValue = Object();

  SchedulesState copyWith({
    List<Schedule>? items,
    bool? isLoading,
    bool? isLoadingMore,
    Object? error = _noValue, // allow explicit null
    int? page,
    bool? hasMore,
    int? totalPages,
    Object? dateFrom = _noValue, // sentinel: allows setting null
    Object? dateTo = _noValue,   // sentinel: allows setting null
  }) {
    return SchedulesState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      // if error was not provided, keep existing; if provided (even null) use it
      error: error == _noValue ? this.error : error as String?,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      totalPages: totalPages ?? this.totalPages,
      // for dateFrom/dateTo: if the sentinel was passed, keep existing; otherwise use provided (which may be null)
      dateFrom: dateFrom == _noValue ? this.dateFrom : dateFrom as DateTime?,
      dateTo: dateTo == _noValue ? this.dateTo : dateTo as DateTime?,
    );
  }
}

class SchedulesNotifier extends StateNotifier<SchedulesState> {
  final GetSchedules _getSchedules;
  final int _limit;
  bool _loadingInProgress = false;

  SchedulesNotifier(this._getSchedules, {int limit = 15})
      : _limit = limit,
        super(const SchedulesState());

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

  // helpers
  DateTime _startOfDay(DateTime d) => DateTime(d.year, d.month, d.day, 0, 0, 0);
  DateTime _endOfDay(DateTime d) => DateTime(d.year, d.month, d.day, 23, 59, 59, 999);

  // Public: mantém compatibilidade
  Future<void> loadInitial() async {
    await _loadInitialWithDates(state.dateFrom, state.dateTo);
  }

  // Implementação que usa explicitamente os valores passados
  Future<void> _loadInitialWithDates(DateTime? dateFrom, DateTime? dateTo) async {
    if (_loadingInProgress) {
      print('[Notifier] _loadInitialWithDates: already running, returning');
      return;
    }
    _loadingInProgress = true;

    try {
      print('[Notifier] _loadInitialWithDates called with dateFrom=$dateFrom dateTo=$dateTo');

      // marca como loading no state
      state = state.copyWith(isLoading: true, error: null);

      // 1) consulta a página 1 para obter totalPages
      print('[Notifier] requesting page=1 with dateFrom=$dateFrom dateTo=$dateTo');
      final firstPageResult = await _getSchedules.call(
        page: 1,
        limit: _limit,
        dateFrom: dateFrom,
        dateTo: dateTo,
      );

      final int totalPages = math.max(1, firstPageResult.totalPages ?? 1);
      print('[Notifier] firstPage.totalPages = $totalPages');

      // 2) agora busca a última página (mais recentes)
      var lastPage = totalPages;
      print('[Notifier] requesting lastPage=$lastPage with dateFrom=$dateFrom dateTo=$dateTo');

      final lastPageResult = await _getSchedules.call(
        page: lastPage,
        limit: _limit,
        dateFrom: dateFrom,
        dateTo: dateTo,
      );

      // aplica filtro local (fallback)
      List<Schedule> accumulated = _filterItemsByDate(lastPageResult.items, dateFrom, dateTo);

      // lowestLoadedPage será atualizado conforme vamos pré-carregar páginas anteriores
      var lowestLoadedPage = lastPage;

      // Se a última página tiver menos que _limit itens e existir página anterior,
      // pré-carregamos páginas anteriores até termos pelo menos _limit ou alcançarmos page 1.
      while (accumulated.length < _limit && lowestLoadedPage > 1) {
        final nextPage = lowestLoadedPage - 1;
        print('[Notifier] prefetching page=$nextPage (to fill initial screen)');
        final pageResult = await _getSchedules.call(
          page: nextPage,
          limit: _limit,
          dateFrom: dateFrom,
          dateTo: dateTo,
        );

        final filtered = _filterItemsByDate(pageResult.items, dateFrom, dateTo);

        // adiciona itens mais antigos ao final (mantendo ordem decrescente por data)
        accumulated = [...accumulated, ...filtered];

        lowestLoadedPage = nextPage;

        // se alcançamos page 1, paramos
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
      );

      print('[Notifier] loaded initial pages from $lowestLoadedPage..$lastPage items=${state.items.length} hasMore=$hasMore');
    } catch (e, st) {
      print('[Notifier] _loadInitialWithDates ERROR: $e\n$st');
      state = state.copyWith(isLoading: false, isLoadingMore: false, error: e.toString());
      rethrow;
    } finally {
      _loadingInProgress = false;
    }
  }

  Future<void> refresh() async {
    await _loadInitialWithDates(state.dateFrom, state.dateTo);
  }

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
      );

      final filtered = _filterItemsByDate(result.items, state.dateFrom, state.dateTo);
      final newItems = [...state.items, ...filtered];
      final hasMore = prevPage > 1;

      state = state.copyWith(
        items: newItems,
        isLoadingMore: false,
        page: prevPage,
        hasMore: hasMore,
        totalPages: result.totalPages,
      );
    } catch (e, st) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
      print('loadMore error: $e\n$st');
    }
  }

  // applyDateRange atualiza o state imediatamente e carrega usando os valores normalizados
  Future<void> applyDateRange(DateTime? from, DateTime? to) async {
    try {
      print('[Notifier] applyDateRange called with raw from=$from to=$to');

      final DateTime? normalizedFrom = from != null ? _startOfDay(from) : null;
      final DateTime? normalizedTo = to != null ? _endOfDay(to) : null;
      print('[Notifier] applyDateRange normalized: dateFrom=$normalizedFrom dateTo=$normalizedTo');

      // Atualiza o state IMEDIATAMENTE com os valores normalizados
      state = state.copyWith(
        dateFrom: normalizedFrom,
        dateTo: normalizedTo,
        page: 1,
        items: [],
        isLoading: true,
        isLoadingMore: false,
        error: null,
        // ajuste outros campos conforme seu state class
      );

      print('[Notifier] state updated (after applyDateRange): dateFrom=${state.dateFrom} dateTo=${state.dateTo}');

      // Chama a rotina de carregamento passando explicitamente os normalizedFrom/To
      await _loadInitialWithDates(normalizedFrom, normalizedTo);
    } catch (e, st) {
      // tratar erro atualizando o estado apropriadamente
      print('[Notifier] applyDateRange ERROR: $e\n$st');
      state = state.copyWith(isLoading: false, error: e.toString());
      rethrow;
    }
  }
}