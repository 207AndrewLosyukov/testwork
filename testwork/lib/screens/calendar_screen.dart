import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:testwork/dependencies.dart';

import '../cubit/news_cubit.dart';

/*
Календарь с выбором даты.
*/
class TableBasicsExample extends StatefulWidget {
  final NewsCubit cubit;
  const TableBasicsExample({required this.cubit, Key? key}) : super(key: key);

  @override
  _TableBasicsExampleState createState() => _TableBasicsExampleState();
}

class _TableBasicsExampleState extends State<TableBasicsExample> {
  @override
  void initState() {
    super.initState();
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = Dependencies.currSelected;
  DateTime? _selectedDay = Dependencies.currSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select date'),
      ),
      body: TableCalendar(
        firstDay: DateTime(2022, 6, 1),
        lastDay: DateTime.now(),
        focusedDay: Dependencies.today,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            Dependencies.currSelected = selectedDay;
          }
          widget.cubit.fetchAllNewsByDate();
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
