import 'package:flutter/material.dart';
import 'package:flutter_kalender/pages/calendar.dart';
//import 'package:table_calendar/table_calendar.dart'; --> vorgefertigtes kalender widget
//vorüberlegung:
/* 
  -Kalender muss gebaut werden, der die Tage und Monate anzeigt.
  -übernahme der funktionen aus der alten version in js
  -erste version als liste/col/row bauen die den monat anzeigt 
  -zweite version nutzt vorgefertigten Kalender widget
  - navigationsbar für verschiedene seiten ( historische ereignisse, kalender, etc.)
  - 
  
 */


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalender',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final currentYear = today.year;
    final currentMonth = today.month;

    const monthNames = [
      'Januar', 'Februar', 'März', 'April', 'Mai', 'Juni',
      'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'
    ];



    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalender'),
        backgroundColor: Colors.blueGrey[800],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '${monthNames[currentMonth - 1]} $currentYear',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Center(
              child: Calendar(
                year: currentYear,
                month: currentMonth,
                width: MediaQuery.of(context).size.width / 2,
    
                selectedDay: _selectedDate,
                onDaySelected: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Ausgewählter Tag: ${date.day}/${date.month}/${date.year}'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _selectedDate == null
                  ? 'kein Tag ausgewählt'
                  : 'Ausgewählter Tag ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
