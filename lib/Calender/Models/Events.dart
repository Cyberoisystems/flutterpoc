class EventsList {
  final String id;
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
}
