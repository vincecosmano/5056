class CalendarEvent {
  final String id;
  final String userId;
  final String title;
  final String description;
  final DateTime date;
  final DateTime startTime;
  final DateTime endTime;

  CalendarEvent({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    };
  }

  factory CalendarEvent.fromMap(Map<String, dynamic> map) {
    return CalendarEvent(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      description: map['description'],
      date: DateTime.parse(map['date']),
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
    );
  }
}
