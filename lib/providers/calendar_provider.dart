import 'package:flutter/material.dart';

class CalendarProvider with ChangeNotifier {
  List<Map<String, dynamic>> _events = [];

  List<Map<String, dynamic>> get events => _events;

  void addEvent(String title, String description, DateTime date, String eventType) {
    _events.add({
      'id': DateTime.now().toString(),
      'title': title,
      'description': description,
      'date': date,
      'eventType': eventType,
    });
    notifyListeners();
  }

  void updateEvent(String id, String title, String description, DateTime date, String eventType) {
    final index = _events.indexWhere((event) => event['id'] == id);
    if (index != -1) {
      _events[index] = {
        'id': id,
        'title': title,
        'description': description,
        'date': date,
        'eventType': eventType,
      };
      notifyListeners();
    }
  }

  void deleteEvent(String id) {
    _events.removeWhere((event) => event['id'] == id);
    notifyListeners();
  }

  List<Map<String, dynamic>> getEventsForDate(DateTime date) {
    return _events.where((event) {
      final eventDate = event['date'] as DateTime;
      return eventDate.year == date.year &&
          eventDate.month == date.month &&
          eventDate.day == date.day;
    }).toList();
  }
}