// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_kalender/services/get_model.dart';
import 'package:flutter_kalender/services/get_services.dart';



class historyPage extends StatefulWidget {
 const historyPage({super.key});

 @override
 State<historyPage> createState() => _historyPageState();
}

class _historyPageState extends State<historyPage> {
  WikiModel? historyModel;

  Future<void> getHistory() async {
    final value = await GetServices().getServices();
    if (!mounted) return;

    setState(() {
      historyModel = value ?? WikiModel(events: const []);
    });
  }

  @override
  void initState() {
    super.initState();
    getHistory();
  }

  @override
  Widget build(BuildContext context) {
    final events = historyModel?.events ?? const [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historische Ereignisse'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: events.length,
        itemBuilder: (context, index) {
          final data = events[index];
          return Material(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(data.text.toString())
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}