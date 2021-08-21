import 'dart:developer';
import 'dart:math';

import 'package:flutter/foundation.dart';

import '../Models/Events.dart';
import '../Helper/Helper_DB.dart';

class EventsProvider with ChangeNotifier {
  List<EventsList> eventsList = [];

  List<EventsList> get getEvents {
    return [...eventsList];
  }

  Future<void> fetchAndSetData(String tableName) async {
    var responce = await HelperDB.getData(tableName);
    eventsList = responce
        .map((data) => EventsList(
              id: data['id'],
              title: data['title'],
              date: DateTime.parse(data['date']),
              eventType: data['eventType'],
              remainderTime: DateTime.parse(data['remainder']),
            ))
        .toList();
    notifyListeners();
  }

  void addEvents(List<EventsList> list) async {
    var ranId = Random().nextInt(pow(2, 31).toInt());
    Map<String, dynamic> data = {
      "id": ranId.toString(),
      "title": list[0].title,
      "date": list[0].date.toString(),
      "eventType": list[0].eventType,
      "remainder": list[0].remainderTime.toString(),
    };
    try {
      HelperDB.insert("eventsTable", data);
      eventsList.insert(
        0,
        EventsList(
          id: ranId.toString(),
          title: list[0].title,
          date: list[0].date,
          eventType: list[0].eventType,
          remainderTime: list[0].remainderTime,
        ),
      );
    } catch (error) {
      throw error;
    }

    notifyListeners();
  }

  void removeEvents(String tableName, String id) async {
    await HelperDB.remove(tableName, id);
    eventsList.removeWhere((event) => event.id == id);
    notifyListeners();
  }
}
