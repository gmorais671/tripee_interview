import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../widgets/schedule_card.dart';
import '../widgets/date_range_filter_button.dart';
import '../providers/global_providers.dart';
import '../../domain/entities/schedule.dart';

class SchedulesPage extends ConsumerStatefulWidget {
  const SchedulesPage({Key? key}) : super(key: key);
  @override
  ConsumerState<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends ConsumerState<SchedulesPage> {
  final _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // load initial
    Future.microtask(() => ref.read(schedulesNotifierProvider.notifier).loadInitial());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    const threshold = 200.0;
    final max = _scrollController.position.maxScrollExtent;
    final pos = _scrollController.position.pixels;
    if (max - pos <= threshold) {
      ref.read(schedulesNotifierProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Agrupa por dia e retorna lista "flattened" onde cada header é String e cada item é Schedule
  List<Object> _flattenWithHeaders(List<Schedule> items) {
    final Map<String, List<Schedule>> map = {};
    final DateFormat headerFormat = DateFormat("dd MMM, yyyy", "pt_BR");

    for (final s in items) {
      final dt = s.scheduleAt?.toLocal();
      final key = dt == null ? 'Sem data' : headerFormat.format(dt);
      map.putIfAbsent(key, () => []).add(s);
    }

    // Ordena as chaves por data descendente (mais recente primeiro)
    final sortedEntries = map.entries.toList()
      ..sort((a, b) {
        final aDate = _parseHeaderDate(a.key);
        final bDate = _parseHeaderDate(b.key);
        return bDate.compareTo(aDate);
      });

    final List<Object> flattened = [];
    for (final e in sortedEntries) {
      // custom header: "Hoje • 25 Nov, 2024" or "Ontem • 24 Nov, 2024"
      final headerText = _friendlyHeader(e.key);
      flattened.add(headerText);
      flattened.addAll(e.value);
    }
    return flattened;
  }

  DateTime _parseHeaderDate(String headerKey) {
    try {
      final DateFormat headerFormat = DateFormat("dd MMM, yyyy", "pt_BR");
      return headerFormat.parse(headerKey);
    } catch (_) {
      return DateTime.fromMillisecondsSinceEpoch(0);
    }
  }

  String _friendlyHeader(String headerKey) {
    try {
      final df = DateFormat("dd MMM, yyyy", "pt_BR");
      final dt = df.parse(headerKey);
      final today = DateTime.now();
      final yesterday = today.subtract(const Duration(days: 1));
      final dtDate = DateTime(dt.year, dt.month, dt.day);
      final tDate = DateTime(today.year, today.month, today.day);
      final yDate = DateTime(yesterday.year, yesterday.month, yesterday.day);
      final formatted = DateFormat("d MMM, yyyy", "pt_BR").format(dt);
      if (dtDate == tDate) return "Hoje • $formatted";
      if (dtDate == yDate) return "Ontem • $formatted";
      return " $formatted";
    } catch (_) {
      return headerKey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(schedulesNotifierProvider);
    final notifier = ref.read(schedulesNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        actions: [],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(schedulesNotifierProvider.notifier).refresh(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date range filter button (sempre visível)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: DateRangeFilterButton(
                onApply: (start, end) async {
                  await notifier.applyDateRange(start, end);
                  if (_scrollController.hasClients) _scrollController.jumpTo(0);
                },
              ),
            ),

            // Search field (sempre visível)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  notifier.applySearch(value);
                },
                onSubmitted: (value) async {
                  await notifier.searchNow(value);
                  if (_scrollController.hasClients) _scrollController.jumpTo(0);
                },
                decoration: InputDecoration(
                  hintText: 'Buscar (endereço, status, id...)',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: state.searchQuery != null && state.searchQuery!.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () async {
                            _searchController.clear();
                            await notifier.searchNow(null);
                            if (_scrollController.hasClients) _scrollController.jumpTo(0);
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor ?? Colors.grey.shade50,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.35), width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.2),
                  ),
                ),
              ),
            ),

            // Área principal: loader / erro / empty / lista
            Expanded(
              child: Builder(builder: (_) {
                // Loading initial + no items -> show loader (but keep filters visible)
                if (state.isLoading && state.items.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Error + no items -> show error message + allow refresh/clear
                if (state.error != null && state.items.isEmpty) {
                  return Center(child: Text('Erro: ${state.error}'));
                }

                // No items -> show empty state + quick action to clear filters (if any)
                if (state.items.isEmpty) {
                  final hasActiveFilters = (state.searchQuery != null && state.searchQuery!.isNotEmpty) ||
                      state.dateFrom != null ||
                      state.dateTo != null;

                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Nenhum agendamento encontrado'),
                        const SizedBox(height: 12),
                        if (hasActiveFilters)
                          ElevatedButton(
                            onPressed: () async {
                              // limpa tanto a busca quanto o date range
                              _searchController.clear();
                              await notifier.searchNow(null);
                              await notifier.applyDateRange(null, null);
                              if (_scrollController.hasClients) _scrollController.jumpTo(0);
                            },
                            child: const Text('Limpar filtros'),
                          ),
                      ],
                    ),
                  );
                }

                // Há items -> renderiza lista agrupada
                final flattened = _flattenWithHeaders(state.items);
                final itemCount = flattened.length + (state.isLoadingMore ? 1 : 0);

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(bottom: 12),
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    if (index < flattened.length) {
                      final obj = flattened[index];
                      if (obj is String) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Text(
                            obj,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        );
                      } else if (obj is Schedule) {
                        return ScheduleCard(schedule: obj);
                      } else {
                        return const SizedBox.shrink();
                      }
                    } else {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}