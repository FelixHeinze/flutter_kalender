/*
//funktion um die Tabelle zu erstellen
    function createCalendar() {
        const table = document.getElementById("kalenderDynamisch");
        const year = _objectDatum.getFullYear();
        const month = _objectDatum.getMonth();

        // Lösche bestehende Zeilen (außer der Header)
        while (table.rows.length > 1) {
            table.deleteRow(1);
        }

        // Erstelle neue Zeilen für den Kalender
        const firstDay = new Date(year, month, 1);
        const lastDay = new Date(year, month + 1, 0);
        const daysInMonth = lastDay.getDate();
        const startingDayOfWeek = firstDay.getDay();
/*         sonntag = 0, montag = 1, dienstag = 2, mittwoch = 3, donnerstag = 4, freitag = 5, samstag = 6
        montag soll 0 werden, also muss 1 abgezogen werden, wenn der Wert 0 ist, soll er 6 sein --> bswp sonntag=0 +6 %7 = 6
         montag=1 +6 %7 =0 ...  */
        const adjustedStartingDayOfWeek = (startingDayOfWeek + 6) % 7;

        let currentRow = table.insertRow();
        let currentCell;

        // Füge leere Zellen für die Tage vor dem ersten Tag hinzu
        for (let i = 0; i < adjustedStartingDayOfWeek; i++) {
            currentCell = currentRow.insertCell();
            currentCell.innerHTML = "";
        }

        // Füge die Tage des Monats hinzu
        for (let day = 1; day <= daysInMonth; day++) {
            if (currentRow.cells.length === 7) {
                currentRow = table.insertRow();
            }
            currentCell = currentRow.insertCell();
            currentCell.innerHTML = day;
            if (day === _objectDatum.getDate()) {
                currentCell.style.backgroundColor = "yellow"; // markiere den aktuellen tag, kann auch als klasse in css ausgelagert werden, später
            }
            // Feiertage markieren
            const currentDate = new Date(year, month, day);
            const isHoliday = feiertage.some(datumFeiertag => datumFeiertag.getTime() === currentDate.getTime());
            if (isHoliday) {
                currentCell.style.backgroundColor = "red"; // markiere feiertage wird in css ausgelagert später
            }
        }
        // leere Zellen für die tage nach dem letzten tag hinzufügen
        while (currentRow.cells.length < 7) {
            currentCell = currentRow.insertCell();
            currentCell.innerHTML = "";
        }
    }

*/
//orientierung an javascript funktion um kalender zu schreiben

import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const new({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(20.0),
    child: Row(
      // Erstellen des Kalenders :
      //aktuelles Datum muss gespeichert werden
      //Tabelle muss geschrieben werden 
      
    ),
    )
      
    
    ;
  }
}