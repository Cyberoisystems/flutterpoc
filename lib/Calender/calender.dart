import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'Helper/Helper_DB.dart';

//Screens
import './Screens/Date.dart';
import './Models/Events.dart';
import 'Provider/Events_provider.dart';

class Calender extends StatefulWidget {
  @override
  CalenderState createState() => CalenderState();
}

showNotification() async {
  print("called notification ${DateTime.now()}");
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
  var responce = await HelperDB.getData('eventsTable');
  // print(responce);
  var eventsList = responce
      .map((data) => EventsList(
            id: data['id'],
            title: data['title'],
            date: DateTime.parse(data['date']),
            eventType: data['eventType'],
            remainderTime: DateTime.parse(data['remainder']),
          ))
      .toList();
  var d = new DateTime.now();
  DateTime date = new DateTime(d.year, d.month, d.day, d.hour, d.minute);
  var events = eventsList
      .where((event) => event.remainderTime.compareTo(date) == 0)
      .toList();
  if (events.length != 0) {
    // print("called inside");
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "local Notification ", "channelDescription",
        importance: Importance.high);
    var iosDetails = new IOSNotificationDetails();
    var generalDetails =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotification.show(
        0, events[0].title, events[0].eventType, generalDetails);
  }
}

class CalenderState extends State<Calender> with TickerProviderStateMixin {
  late List itemListDynamic;
  late List<EventsList> ListItem;
  late TabController tb;
  var isLoaded = false;

  @override
  void didChangeDependencies() {
    if (!isLoaded) {
      Provider.of<EventsProvider>(context, listen: false)
          .fetchAndSetData("eventsTable");
    }
    setState(() {
      isLoaded = true;
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    tb = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  void deleteEvent(id) {
    Provider.of<EventsProvider>(context, listen: false)
        .removeEvents("eventsTable", id);
  }

  eventHandler(
    snackbar,
    String title,
    String eventtype,
    DateTime d,
    DateTime remainder,
  ) {
    if (title == "" || eventtype == "" || remainder == null) {
      return ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }

    List<EventsList> list = [
      EventsList(
          id: DateTime.now().toIso8601String(),
          title: title,
          date: d,
          eventType: eventtype,
          remainderTime: remainder),
    ].toList();
    Provider.of<EventsProvider>(context, listen: false).addEvents(list);
  }

  @override
  Widget build(BuildContext context) {
    List<EventsList> listOfEvents =
        Provider.of<EventsProvider>(context).getEvents;
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
          ListView.builder(
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
                          listOfEvents[index].date,
                        ),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    title: Text(
                      listOfEvents[index].title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      listOfEvents[index].eventType,
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
                      onPressed: () => deleteEvent(listOfEvents[index].id),
                    )),
              );
            },
            itemCount: listOfEvents.length,
          ),
        ],
        controller: tb,
      ),
    );
  }
}
