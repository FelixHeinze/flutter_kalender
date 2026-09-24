import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  final DateTime initialDate;
  final void Function(DateTime) onDaySelected;

  const Calendar({
    super.key,
    required this.initialDate,
    required this.onDaySelected,
  });

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late DateTime _displayedMonth;

  @override
  void initState() {
    super.initState();
    _displayedMonth = DateTime(
      widget.initialDate.year,
      widget.initialDate.month,
    );
  }

  @override
  void didUpdateWidget(covariant Calendar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialDate.year != widget.initialDate.year ||
        oldWidget.initialDate.month != widget.initialDate.month) {
      _displayedMonth = DateTime(
        widget.initialDate.year,
        widget.initialDate.month,
      );
    }
  }

  void _changeMonth(int amount) {
    setState(() {
      _displayedMonth = DateTime(
        _displayedMonth.year,
        _displayedMonth.month + amount,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = constraints.maxWidth < 500 ? 12.0 : 24.0;
        final calendarWidth =
            (constraints.maxWidth - horizontalPadding * 2).clamp(0.0, 700.0);

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: 16,
          ),
          child: Center(
            child: SizedBox(
              width: calendarWidth,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        tooltip: 'Vorheriger Monat',
                        onPressed: () => _changeMonth(-1),
                        icon: const Icon(Icons.chevron_left),
                      ),
                      Flexible(
                        child: Text(
                          '${_monthName(_displayedMonth.month)} '
                          '${_displayedMonth.year}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      IconButton(
                        tooltip: 'Nächster Monat',
                        onPressed: () => _changeMonth(1),
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  CalendarGrid(
                    year: _displayedMonth.year,
                    month: _displayedMonth.month,
                    width: calendarWidth,
                    selectedDay: widget.initialDate,
                    onDaySelected: widget.onDaySelected,
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.event),
                      title: const Text('Ausgewählter Tag'),
                      subtitle: Text(_formatDate(widget.initialDate)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _monthName(int month) {
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
    return months[month - 1];
  }

  String _formatDate(DateTime date) {
    return '${date.day}. ${_monthName(date.month)} ${date.year}';
  }
}

class CalendarGrid extends StatelessWidget {
  final int year;
  final int month;
  final double width;
  final Map<DateTime, Widget>? dayContents;
  final Map<DateTime, Color>? dayColors;
  final void Function(DateTime)? onDaySelected;
  final DateTime? selectedDay;

  const CalendarGrid({
    super.key,
    required this.year,
    required this.month,
    required this.width,
    this.dayContents,
    this.dayColors,
    this.onDaySelected,
    this.selectedDay,
  });

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(year, month + 1, 0).day;
    final firstDayOfMonth = DateTime(year, month, 1);

    // DateTime.weekday: Montag = 1 ... Sonntag = 7.
    final emptyDaysAtStart = firstDayOfMonth.weekday - 1;

    final daysToDisplay = <int?>[
      ...List<int?>.filled(emptyDaysAtStart, null),
      ...List<int>.generate(daysInMonth, (index) => index + 1),
    ];

    // Immer genau 6 Wochen anzeigen. Dadurch bleibt die Höhe
    // des Kalenders stabil und es entsteht kein Layout-Overflow.
    while (daysToDisplay.length < 42) {
      daysToDisplay.add(null);
    }

    final cellSize = width / 7;

    return Column(
      children: [
        _WeekdayHeader(cellSize: cellSize),
        const SizedBox(height: 6),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
          ),
          itemCount: daysToDisplay.length,
          itemBuilder: (context, index) {
            final day = daysToDisplay[index];

            if (day == null) {
              return const SizedBox.shrink();
            }

            final date = DateTime(year, month, day);

            final isSelected = selectedDay != null &&
                selectedDay!.year == year &&
                selectedDay!.month == month &&
                selectedDay!.day == day;

            final today = DateTime.now();
            final isToday = today.year == year &&
                today.month == month &&
                today.day == day;

            final backgroundColor =
                dayColors?[DateTime(year, month, day)] ??
                (isToday
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest);

            return InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onDaySelected == null
                  ? null
                  : () => onDaySelected!(date),
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.black12,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 5,
                      right: 6,
                      child: Text(
                        '$day',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (dayContents != null &&
                        dayContents!.containsKey(date))
                      Center(child: dayContents![date]),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _WeekdayHeader extends StatelessWidget {
  final double cellSize;

  const _WeekdayHeader({required this.cellSize});

  @override
  Widget build(BuildContext context) {
    const weekdays = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];

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
