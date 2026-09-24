import 'package:flutter/material.dart';
import 'package:flutter_kalender/services/get_model.dart';
import 'package:flutter_kalender/services/get_services.dart';

class historyPage extends StatefulWidget {
  final DateTime date;

  const historyPage({
    super.key,
    required this.date,
  });

  @override
  State<historyPage> createState() => _historyPageState();
}

class _historyPageState extends State<historyPage> {
  WikiModel? historyModel;
  bool loading = true;
  String? error;

  Future<void> getHistory() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final value = await GetServices().getServices(widget.date);

      if (!mounted) return;

      setState(() {
        historyModel = value ?? WikiModel(events: const []);
        loading = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        loading = false;
        error = 'Die historischen Ereignisse konnten nicht geladen werden.';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  @override
  void didUpdateWidget(covariant historyPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.date.year != widget.date.year ||
        oldWidget.date.month != widget.date.month ||
        oldWidget.date.day != widget.date.day) {
      getHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cloud_off, size: 48),
              const SizedBox(height: 12),
              Text(error!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: getHistory,
                icon: const Icon(Icons.refresh),
                label: const Text('Erneut versuchen'),
              ),
            ],
          ),
        ),
      );
    }

    final events = historyModel?.events ?? const [];

    return RefreshIndicator(
      onRefresh: getHistory,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: events.isEmpty ? 2 : events.length + 1,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Card(
              child: ListTile(
                leading: const Icon(Icons.event),
                title: const Text('Historische Ereignisse'),
                subtitle: Text(_formatDate(widget.date)),
              ),
            );
          }

          if (events.isEmpty) {
            return const Padding(
              padding: EdgeInsets.only(top: 80),
              child: Center(
                child: Text('Keine Ereignisse für diesen Tag gefunden.'),
              ),
            );
          }

          final event = events[index - 1];

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                event.text,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Januar',
      'Februar',
      'März',
      'April',
      'Mai',
      'Juni',
      'Juli',
      'August',
      'September',
      'Oktober',
      'November',
      'Dezember',
    ];

    return '${date.day}. ${months[date.month - 1]} ${date.year}';
  }
}
