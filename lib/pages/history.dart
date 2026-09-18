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
  late WikiModel historyModel;
   getHistory(){
    GetServices().getServices().then((value) {
      setState(() {
        historyModel != WikiModel;
      });
    });
  }
  @override
  void initState() {
    getHistory();
    super.initState();
    }

  @override

 Widget build(BuildContext context) {
 return Scaffold(
    appBar: AppBar(
      title: const Text('Historische Ereignisse'),),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: historyModel.events.length,
        itemBuilder: (context, index) {
          final data = historyModel.events[index];
          return Material(
            child: Row(
              children:[ 
              Text(data.toString()),
              Text(historyModel.events.toString()),
              Text("test"),
            ]
            ),
            
          );
        },
      ),
    )
;

}}