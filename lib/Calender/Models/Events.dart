class EventsList {
  final int id;
  final String title;
  final DateTime date;
  final String eventType;
  DateTime remainderTime;

  EventsList({
    required this.id,
    required this.title,
    required this.date,
    required this.eventType,
    required this.remainderTime,
  });

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['title'] = title;
    m['date'] = date.toIso8601String();
    m['id'] = id.toString();
    m['eventType'] = eventType;
    m['remainderTime'] = remainderTime.toIso8601String();

    return m;
  }
}
