import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/schedule_card.dart';
import '../providers/global_providers.dart';

class SchedulesPage extends ConsumerStatefulWidget {
  const SchedulesPage({Key? key}) : super(key: key);
  @override
  ConsumerState<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends ConsumerState<SchedulesPage> {
  final _scrollController = ScrollController();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(schedulesNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined),
            onPressed: () async {
              // open DateRangePicker and call notifier.applyDateRange(...)
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(schedulesNotifierProvider.notifier).refresh(),
        child: Builder(builder: (_) {
          if (state.isLoading && state.items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null && state.items.isEmpty) {
            return Center(child: Text('Erro: ${state.error}'));
          }

          if (state.items.isEmpty) {
            return const Center(child: Text('Nenhum agendamento encontrado'));
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: state.items.length + (state.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < state.items.length) {
                final s = state.items[index];
                return ScheduleCard(schedule: s);
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
    );
  }
}