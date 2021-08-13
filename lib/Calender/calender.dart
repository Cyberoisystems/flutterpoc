import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:myapp/main.dart';
//Screens
import './Screens/Date.dart';
import './Models/Events.dart';

class Calender extends StatefulWidget {
  @override
  CalenderState createState() => CalenderState();
}

printSomething() {
  print("called");
}

class CalenderState extends State<Calender> with TickerProviderStateMixin {
  late FlutterLocalNotificationsPlugin localNotification;
  late TabController tb;

  List<EventsList> eventList = [
    EventsList(
      id: 1,
      title: "sam's birthday",
      date: DateTime.now(),
      eventType: "birthday",
      alarmIndicator: true,
      remainderTime: DateTime.now(),
    )
  ];

  void alarmHandler(id) {
    eventList.forEach((item) {
      if (item.id == id) {
        setState(() {
          item.alarmIndicator = !item.alarmIndicator;
        });
      }
    });
  }

  @override
  void initState() {
    tb = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
    var androidInitialize = new AndroidInitializationSettings('ic_launcher');
    var iosInitialze = new IOSInitializationSettings();
    var initalizationSetting = new InitializationSettings(
      android: androidInitialize,
      iOS: iosInitialze,
    );
    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(initalizationSetting);
    AndroidAlarmManager.initialize();
  }

  eventHandler(
    snackbar,
    String title,
    String eventtype,
    DateTime d,
    DateTime remainder,
  ) async {
    if (title == "" || eventtype == "") {
      return ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
    // print(remainder);
    var event = EventsList(
      id: eventList[eventList.length - 1].id + 1,
      title: title,
      date: d,
      eventType: eventtype,
      alarmIndicator: true,
      remainderTime: remainder,
    );

    await AndroidAlarmManager.oneShot(
        const Duration(seconds: 5), 0, printSomething,
        exact: true, wakeup: true);
    setState(() {
      eventList.add(event);
    });
  }

  showNotification() async {
    // print(d);
    // var events = eventList
    //     .where((event) => event.remainderTime.compareTo(d) == 0)
    //     .toList();
    // print("event detail ${events.length}");
    // if (events.length != 0) {
    print("called inside");
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "local Notification ", "channelDescription",
        importance: Importance.high);
    var iosDetails = new IOSNotificationDetails();
    var generalDetails =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotification.show(0, "title", "name", generalDetails);
    // await localNotification.schedule(
    //     0, events[0].title, events[0].eventType, d, generalDetails);
    // }
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    var appBar = AppBar(
      centerTitle: true,
      title: Text(
        "Calender App",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottom: TabBar(
        tabs: <Widget>[
          Text(
            "Date",
            style: Theme.of(context).textTheme.title,
          ),
          Text(
            "Events",
            style: Theme.of(context).textTheme.title,
          ),
        ],
        controller: tb,
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: TabBarView(
        children: [
          Container(
              height: (mediaquery.size.height -
                      appBar.preferredSize.height -
                      mediaquery.padding.top) *
                  0.5,
              child: CalenderDate(eventHandler)),
          Expanded(
            child: Container(
              height: (mediaquery.size.height -
                      appBar.preferredSize.height -
                      mediaquery.padding.top) *
                  0.5,
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 7,
                    margin: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 5,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purple,
                        radius: 20,
                        child: Text(
                          DateFormat.d().format(
                            eventList[index].date,
                          ),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      title: Text(
                        eventList[index].title,
                        // DateFormat.Hms().format(eventList[index].remainderTime),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        eventList[index].eventType,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      trailing: eventList[index].alarmIndicator
                          ? IconButton(
                              icon: Icon(
                                Icons.alarm,
                                color: Colors.purpleAccent,
                                size: 30,
                              ),
                              onPressed: () =>
                                  alarmHandler(eventList[index].id),
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.alarm,
                                size: 30,
                              ),
                              onPressed: () =>
                                  alarmHandler(eventList[index].id),
                            ),
                    ),
                  );
                },
                itemCount: eventList.length,
              ),
            ),
          ),
        ],
        controller: tb,
      ),
    );
  }
}
