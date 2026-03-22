import 'package:flutter/material.dart';

class CalendarProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _events = [];

  List<Map<String, dynamic>> get events => _events;

  void addEvent(Map<String, dynamic> event) {
    _events.add(event);
    notifyListeners();
  }

  void updateEvent(int index, Map<String, dynamic> event) {
    _events[index] = event;
    notifyListeners();
  }

  void deleteEvent(int index) {
    _events.removeAt(index);
    notifyListeners();
  }

  void clearEvents() {
    _events.clear();
    notifyListeners();
  }

  List<Map<String, dynamic>> getEventsForDate(DateTime date) {
    return _events.where((event) {
      DateTime eventDate = DateTime.parse(event['date']);
      return eventDate.year == date.year &&
          eventDate.month == date.month &&
          eventDate.day == date.day;
    }).toList();
  }
}
