import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderDate extends StatefulWidget {
  final Function eventHandler;
  CalenderDate(this.eventHandler);
  @override
  _CalenderDateState createState() => _CalenderDateState();
}

class _CalenderDateState extends State<CalenderDate> {
  final _eventFieldController = TextEditingController();
  final _titleFieldController = TextEditingController();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime currenDay = DateTime.now();
  static DateTime focusDay = DateTime.now();
  TimeOfDay remainderTime = TimeOfDay.now();
  DateTime? remainderDateTime;
  final snackBar = SnackBar(
    content: Text('Please fill Event Detail properly!!'),
  );

  Future<void> _showTimePicker(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: remainderTime,
    );
    if (pickedTime != null) {
      setState(() {
        remainderTime = pickedTime;
        remainderDateTime = new DateTime(
          focusDay.year,
          focusDay.month,
          focusDay.day,
          remainderTime.hour,
          remainderTime.minute,
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TableCalendar(
            availableGestures: AvailableGestures.all,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              weekendStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            headerStyle: HeaderStyle(
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarStyle: CalendarStyle(
              weekendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              defaultTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            onDaySelected: (
              DateTime selectDay,
              DateTime focusday,
            ) {
              setState(() {
                selectedDay = selectDay;
                focusDay = focusday;
                remainderDateTime = new DateTime(
                  focusday.year,
                  focusday.month,
                  focusday.day,
                  remainderTime.hour,
                  remainderTime.minute,
                );
              });
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },
            currentDay: currenDay,
            calendarFormat: _calendarFormat,
            focusedDay: focusDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2025),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  color: Colors.black,
                  height: 10,
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Text(
                    "EVENTS",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: TextField(
                    controller: _titleFieldController,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      focusedBorder: new OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      prefixIcon: Icon(Icons.list_alt),
                      labelText: "Title",
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 4),
                  child: TextField(
                    controller: _eventFieldController,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.blue),
                      suffixStyle: TextStyle(color: Colors.black),
                      focusedBorder: new OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      prefixIcon: Icon(
                        Icons.celebration,
                      ),
                      labelText: "Event Type",
                      labelStyle: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 7,
                    horizontal: 4,
                  ),
                  child: Row(
                    children: [
                      Text(remainderDateTime == null
                          ? "Remainder not Set yet!!"
                          : remainderTime.minute.toString().length == 1
                              ? "Picked Time ${remainderTime.hour}: 0${remainderTime.minute}"
                              : "Picked Time ${remainderTime.hour}:${remainderTime.minute}"),
                      // : remainderTime.toString()),
                      SizedBox(
                        width: 10,
                      ),
                      FlatButton(
                        onPressed: () => _showTimePicker(context),
                        child: Text(
                          "Set Remainder",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 4),
                      child: ElevatedButton.icon(
                        onPressed: () => widget.eventHandler(
                          snackBar,
                          _titleFieldController.text,
                          _eventFieldController.text,
                          focusDay,
                          remainderDateTime,
                        ),
                        icon: Icon(
                          Icons.add,
                          size: 25,
                        ),
                        label: Text(
                          "Add",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
