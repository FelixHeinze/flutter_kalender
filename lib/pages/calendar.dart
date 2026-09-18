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



class Calendar extends StatelessWidget {
  final int year;
  final int month;
  final double width;
  final Map<DateTime, Widget>? dayContents;
  final Map<DateTime, Color>? dayColors;
  final void Function(DateTime)? onDaySelected;
  final DateTime? selectedDay;

  const Calendar({
    super.key,
    required this.year,
    required this.month,
    required this.width,
    this.dayContents,
    this.dayColors,
    this.onDaySelected,
    this.selectedDay,
  }) : assert(month >= 1 && month <= 12, 'Monat muss zwische 1-12 sein');

  @override
  Widget build(BuildContext context) {
    final int daysInMonth = DateTime(year, month + 1, 0).day;
    final firstDayOfMonth = DateTime(year, month, 1);
    final int startingWeekday = (firstDayOfMonth.weekday % 7) + 1;



    final List<int?> daysToDisplay = _generateDayList(
      startingWeekday,
      daysInMonth,
    );
    final double cellSize = width / 7;

    return SizedBox(
      width: width,
      child: Column(
        children: [
          _WeekdayHeader(cellSize: cellSize),
          const SizedBox(height: 4),
          _CalendarGrid(
            year: year,
            month: month,
            days: daysToDisplay,
            cellSize: cellSize,
            onDaySelected: onDaySelected,
            selectedDay: selectedDay,
          ),
        ],
      ),
    );
  }

  List<int?> _generateDayList(int startingWeekday, int daysInMonth) {
    final List<int?> days = [];
    final int emptyDaysAtStart = startingWeekday - 1;
    for (int i = 0; i < emptyDaysAtStart; i++) {
      days.add(null);
    }
    for (int i = 1; i <= daysInMonth; i++) {
      days.add(i);
    }
    return days;
  }
}

class _WeekdayHeader extends StatelessWidget {
  final double cellSize;
  const _WeekdayHeader({required this.cellSize});

  @override
  Widget build(BuildContext context) {
    const weekdays = ['S', 'M', 'D', 'M', 'D', 'F', 'S'];
    return Row(
      children: weekdays.map((day) {
        return SizedBox(
          width: cellSize,
          child: Text(
            day,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  final int year;
  final int month;
  final List<int?> days;
  final double cellSize;
  final Map<int, Widget>? dayContents;
  final Map<int, Color>? dayColors;
  final void Function(DateTime)? onDaySelected;
  final DateTime? selectedDay;

  const _CalendarGrid({
    required this.year,
    required this.month,
    required this.days,
    required this.cellSize,
    this.dayContents,
    this.dayColors,
    this.onDaySelected,
    this.selectedDay,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemCount: days.length,
      itemBuilder: (context, index) {
        final day = days[index];

        if (day == null) {
          return const SizedBox.shrink();
        }

        final Widget? dayContent = (dayContents != null && dayContents!.containsKey(day)) ? dayContents![day] : null;
        final Color backgroundColor = (dayColors != null && dayColors!.containsKey(day)) ? dayColors![day]! : Colors.grey[200]!;

        final bool isSelected = selectedDay != null &&
            selectedDay!.year == year &&
            selectedDay!.month == month &&
            selectedDay!.day == day;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              if (onDaySelected != null) {
                final clickedDate = DateTime(year, month, day);
                onDaySelected!(clickedDate);
              }
            },
            child: Container(
              height: cellSize,
              width: cellSize,
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(4),
                border: isSelected
                    ? Border.all(color: Colors.blueGrey[700]!, width: 2.5)
                    : Border.all(color: Colors.black12, width: 1),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Text(
                      day.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  if (dayContent != null)
                    Center(
                      child: dayContent,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
