import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:localstorage/localstorage.dart';
import './Models/eventList.dart';

//Screens
import './Screens/Date.dart';
import './Models/Events.dart';

class Calender extends StatefulWidget {
  @override
  CalenderState createState() => CalenderState();
}

printSomething() {
  print(DateTime.now());
}

showNotification() async {
  EventList c1 = new EventList();
  CalenderState c2 = new CalenderState();
  late FlutterLocalNotificationsPlugin localNotification;
  var androidInitialize = new AndroidInitializationSettings('ic_launcher');
  var iosInitialze = new IOSInitializationSettings();
  var initalizationSetting = new InitializationSettings(
    android: androidInitialize,
    iOS: iosInitialze,
  );
  localNotification = new FlutterLocalNotificationsPlugin();
  localNotification.initialize(initalizationSetting);
  List item = c2.storage.getItem('events');
  if (item == null) {
    return;
  }
  print("item1 : $item ");
  late List item2;
  if (item != null) {
    print("called inside");
    item2 = await List<EventsList>.from(
      (item as List).map(
        (data) => EventsList(
          title: data['title'],
          date: DateTime.parse(data['date']),
          id: int.parse(data['id']),
          eventType: data['eventType'],
          remainderTime: DateTime.parse(data['remainderTime']),
        ),
      ),
    );
  }
  print(item2.runtimeType);
  // item2.forEach((items) => print(items.title));
  print("original EventList : ${c1.list.runtimeType}");
  var d = new DateTime.now();
  DateTime date = new DateTime(d.year, d.month, d.day, d.hour, d.minute);
  var events =
      item2.where((event) => event.remainderTime.compareTo(date) == 0).toList();
  print("event detail ${events.length}${c1.list.length}");
  if (events.length != 0) {
    print("called inside");
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "local Notification ", "channelDescription",
        importance: Importance.high);
    var iosDetails = new IOSNotificationDetails();
    var generalDetails =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotification.show(
        0, events[0].title, events[0].eventType, generalDetails);
  }
  item2 = List.empty();
  item = List.empty();
  events = List.empty();
}

class CalenderState extends State<Calender> with TickerProviderStateMixin {
  EventList listOfEvents = new EventList();
  final LocalStorage storage = new LocalStorage('calender-app');
  late List itemListDynamic;
  late List<EventsList> ListItem;
  late TabController tb;

  @override
  void initState() {
    tb = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
    itemListDynamic = storage.getItem('events');
    ListItem = List<EventsList>.from(
      (itemListDynamic as List).map(
        (data) => EventsList(
          title: data['title'],
          date: DateTime.parse(data['date']),
          id: int.parse(data['id']),
          eventType: data['eventType'],
          remainderTime: DateTime.parse(data['remainderTime']),
        ),
      ),
    );
    if (ListItem != null) {
      if (listOfEvents.list.length != 1) {
        setState(() {
          listOfEvents.list.replaceRange(0, 0, ListItem);
        });
      }
    }

    saveToStorage();
  }

  saveToStorage() {
    print("events length ${listOfEvents.list.length}");
    storage.setItem('events', listOfEvents.toJSONEncodable());
    var item = storage.getItem('events');
    print("localStorage Events length ${item.length} ");
  }

  deleteEvent(id) {
    setState(() {
      listOfEvents.list.removeWhere((event) => event.id.compareTo(id) == 0);
    });
    saveToStorage();
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
    var event = EventsList(
      id: listOfEvents.list[listOfEvents.list.length - 1].id + 1,
      title: title,
      date: d,
      eventType: eventtype,
      remainderTime: remainder,
    );
    setState(() {
      listOfEvents.list.add(event);
    });
    saveToStorage();
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
                              listOfEvents.list[index].date,
                            ),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        title: Text(
                          listOfEvents.list[index].title,
                          // DateFormat.Hms().format(listOfEvents.list[index].remainderTime),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          listOfEvents.list[index].eventType,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 30,
                          ),
                          onPressed: () =>
                              deleteEvent(listOfEvents.list[index].id),
                        )),
                  );
                },
                itemCount: listOfEvents.list.length,
              ),
            ),
          ),
        ],
        controller: tb,
      ),
    );
  }
}
