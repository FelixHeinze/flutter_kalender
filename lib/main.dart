import 'package:flutter/material.dart';
import 'package:flutter_kalender/pages/history.dart';
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
     home: historyPage(),
    );
  }
}
