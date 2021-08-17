import './Events.dart';

class EventList {
  List<EventsList> list = [
    EventsList(
      id: 1,
      title: "sam's birthday",
      date: DateTime.now(),
      eventType: "birthday",
      remainderTime: DateTime.now(),
    )
  ];

  toJSONEncodable() {
    return list.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}
