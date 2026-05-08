import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../providers/global_providers.dart'; // ajuste o caminho se necessário

class DateRangeFilterButton extends ConsumerStatefulWidget {
  final Future<void> Function(DateTime? start, DateTime? end) onApply;
  final String label;

  const DateRangeFilterButton({
    super.key,
    required this.onApply,
    this.label = 'Período',
  });

  @override
  ConsumerState<DateRangeFilterButton> createState() => _DateRangeFilterButtonState();
}

class _DateRangeFilterButtonState extends ConsumerState<DateRangeFilterButton> {
  // flag para prevenir múltiplas chamadas de onApply dentro do modal
  bool _appliedInModal = false;

  String _formatRange(DateTime? start, DateTime? end) {
    final f = DateFormat('dd MMM', 'pt_BR');
    if (start == null && end == null) return widget.label;
    if (start != null && end != null) return '${f.format(start)} – ${f.format(end)}';
    if (start != null) return 'Desde ${f.format(start)}';
    return 'Até ${f.format(end!)}';
  }

  Future<void> _openModal(BuildContext context, DateTime? initialStart, DateTime? initialEnd) async {
    DateTime? start = initialStart;
    DateTime? end = initialEnd;

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        final now = DateTime.now();
        final firstDate = DateTime(2000);
        final lastDate = DateTime(now.year + 5, now.month, now.day);

        _appliedInModal = false;

        // safeApply: atualiza label localmente e chama onApply em background
        void _safeApply(DateTime? s, DateTime? e) {
          if (_appliedInModal) return;
          _appliedInModal = true;

          // atualiza o display imediatamente no próprio botão via rebuild do provider
          // (opcional) também podemos setState localmente, mas como o botão lê provider, o provider deve mudar.
          // Chamamos a callback em background:
          widget.onApply(s, e).then((_) {
            // sucesso: nada extra aqui
          }).catchError((err, st) {
            // em caso de erro, libera para permitir nova tentativa e mostra feedback
            _appliedInModal = false;
            try {
              ScaffoldMessenger.of(ctx).showSnackBar(
                SnackBar(content: Text('Erro ao aplicar filtro: ${err.toString()}')),
              );
            } catch (_) {}
          });
        }

        return StatefulBuilder(builder: (context, setState) {
          PickerDateRange? _initialRange() {
            if (start == null && end == null) return null;
            final s = start ?? end;
            final e = end ?? start ?? s;
            return PickerDateRange(s, e);
          }

          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 640),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Data inicial - Data final',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _safeApply(start, end);
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('Salvar', style: TextStyle(color: Colors.blue)),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  // resumo e limpar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _formatRange(start, end),
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 6),
                              if (start != null && end != null)
                                Text(
                                  'Duração: ${end!.difference(start!).inDays + 1} dias',
                                  style: const TextStyle(color: Colors.grey),
                                )
                              else
                                const Text('Selecione início e fim', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            start = null;
                            end = null;
                            _safeApply(null, null);
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('Limpar', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  // Calendário único com seleção de intervalo (Syncfusion)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: SfDateRangePicker(
                        selectionMode: DateRangePickerSelectionMode.range,
                        initialSelectedRange: _initialRange(),
                        minDate: firstDate,
                        maxDate: lastDate,
                        monthViewSettings: const DateRangePickerMonthViewSettings(
                          firstDayOfWeek: 1, // optional: start week on Monday
                        ),
                        headerStyle: const DateRangePickerHeaderStyle(
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                          if (args.value is PickerDateRange) {
                            final range = args.value as PickerDateRange;
                            setState(() {
                              start = range.startDate != null
                                  ? DateTime(range.startDate!.year, range.startDate!.month, range.startDate!.day)
                                  : null;
                              end = range.endDate != null
                                  ? DateTime(range.endDate!.year, range.endDate!.month, range.endDate!.day)
                                  : null;
                            });
                          }
                        },
                        rangeSelectionColor: Theme.of(context).primaryColor.withOpacity(0.16),
                        rangeTextStyle: TextStyle(color: Theme.of(context).primaryColor),
                        startRangeSelectionColor: Theme.of(context).primaryColor,
                        endRangeSelectionColor: Theme.of(context).primaryColor,
                        showActionButtons: false,
                      ),
                    ),
                  ),
                  // Bottom ações (Voltar / Salvar)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: const Text('Voltar'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            _safeApply(start, end);
                            Navigator.of(ctx).pop();
                          },
                          child: const Text('Salvar'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // lê DATE FROM / TO diretamente do provider para garantir consistência
    final state = ref.watch(schedulesNotifierProvider);
    final display = _formatRange(state.dateFrom, state.dateTo);

    return TextButton.icon(
      onPressed: () async {
        await _openModal(context, state.dateFrom, state.dateTo);
      },
      icon: const Icon(Icons.expand_more_rounded, color: Colors.black54),
      label: Text(display, style: const TextStyle(color: Colors.black87)),
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}