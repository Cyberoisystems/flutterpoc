class EventsList {
  final int id;
  final String title;
  final DateTime date;
  final String eventType;
  bool alarmIndicator;
  DateTime remainderTime;

  EventsList({
    required this.id,
    required this.title,
    required this.date,
    required this.eventType,
    required this.alarmIndicator,
    required this.remainderTime,
  });
}
