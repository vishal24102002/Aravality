import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  CalendarFormat format=CalendarFormat.month;
  DateTime selectedday=DateTime.now();
  DateTime focusedday=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.lightGreenAccent,
        title: const Text(
            "Calender",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
      ),
      body: AnimatedContainer(
        padding: const EdgeInsets.only(
          top: 40,
        ),
        duration: const Duration(seconds: 1),
        child: TableCalendar(
          // locale: 'en_EN',
          calendarFormat: format,
          focusedDay: selectedday,
          firstDay: DateTime.utc(2023),
          lastDay: DateTime.utc(2030),
          weekNumbersVisible: false,
          onFormatChanged: (CalendarFormat format){
            setState(() {
              format=format;
            });
          },
          holidayPredicate: (day) {
            List Holiday=[DateTime.utc(DateTime.now().year,10,24),DateTime.utc(2024,2,5),DateTime.utc(2024,1,26) ];
            // for (DateTime _date in Holiday){
              return  Holiday.contains(day);
            // }
          },
          startingDayOfWeek: StartingDayOfWeek.monday,
           headerStyle: const HeaderStyle(
             titleCentered: true,
             formatButtonVisible: false,
             rightChevronVisible: false,
               leftChevronVisible: false,
             titleTextStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)
           ),
          calendarStyle: const CalendarStyle(
            outsideDaysVisible: false,
            todayTextStyle: TextStyle(fontWeight:FontWeight.bold,color: Colors.red),
            weekendTextStyle: TextStyle(color: Colors.red),
            holidayTextStyle: TextStyle(color:Colors.red,),

          ),
          onDaySelected: (DateTime selectDay,DateTime focusDay){
            setState(() {
              selectedday=selectDay;
              focusedday=focusDay;
            });
            print(selectedday);
          },
          selectedDayPredicate: (DateTime date){
            return isSameDay(selectedday, date);
          },
        ),
      ),
    );
  }
}
