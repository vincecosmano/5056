import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CalendarProvider with ChangeNotifier {
  static const _key = 'calendar_events';
  List<Map<String, dynamic>> _events = [];

  List<Map<String, dynamic>> get events => _events;

  CalendarProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw != null) {
      final list = jsonDecode(raw) as List<dynamic>;
      _events = list.map((e) {
        final m = Map<String, dynamic>.from(e as Map);
        m['date'] = DateTime.parse(m['date'] as String);
        return m;
      }).toList();
      notifyListeners();
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final serializable = _events.map((ev) {
      final copy = Map<String, dynamic>.from(ev);
      if (copy['date'] is DateTime) {
        copy['date'] = (copy['date'] as DateTime).toIso8601String();
      }
      return copy;
    }).toList();
    await prefs.setString(_key, jsonEncode(serializable));
  }

  void addEvent(String title, String description, DateTime date, String eventType) {
    _events.add({
      'id': DateTime.now().toString(),
      'title': title,
      'description': description,
      'date': date,
      'eventType': eventType,
    });
    _save();
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
      _save();
      notifyListeners();
    }
  }

  void deleteEvent(String id) {
    _events.removeWhere((event) => event['id'] == id);
    _save();
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