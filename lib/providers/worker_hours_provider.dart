import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerHoursProvider with ChangeNotifier {
  static const _key = 'worker_hours';
  List<Map<String, dynamic>> _workerHours = [];

  List<Map<String, dynamic>> get workerHours => _workerHours;

  WorkerHoursProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw != null) {
      final list = jsonDecode(raw) as List<dynamic>;
      _workerHours = list.map((e) {
        final m = Map<String, dynamic>.from(e as Map);
        m['hoursWorked'] = (m['hoursWorked'] as num).toDouble();
        m['hourlyRate'] = (m['hourlyRate'] as num).toDouble();
        m['totalCost'] = (m['totalCost'] as num).toDouble();
        m['date'] = DateTime.parse(m['date'] as String);
        return m;
      }).toList();
      notifyListeners();
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final serializable = _workerHours.map((wh) {
      final copy = Map<String, dynamic>.from(wh);
      if (copy['date'] is DateTime) {
        copy['date'] = (copy['date'] as DateTime).toIso8601String();
      }
      return copy;
    }).toList();
    await prefs.setString(_key, jsonEncode(serializable));
  }

  void addWorkerHours(String workerId, double hoursWorked, DateTime date,
      String description, double hourlyRate) {
    _workerHours.add({
      'id': DateTime.now().toString(),
      'workerId': workerId,
      'hoursWorked': hoursWorked,
      'date': date,
      'description': description,
      'hourlyRate': hourlyRate,
      'totalCost': hoursWorked * hourlyRate,
    });
    _save();
    notifyListeners();
  }

  void updateWorkerHours(String id, String workerId, double hoursWorked,
      DateTime date, String description, double hourlyRate) {
    final index = _workerHours.indexWhere((wh) => wh['id'] == id);
    if (index != -1) {
      _workerHours[index] = {
        'id': id,
        'workerId': workerId,
        'hoursWorked': hoursWorked,
        'date': date,
        'description': description,
        'hourlyRate': hourlyRate,
        'totalCost': hoursWorked * hourlyRate,
      };
      _save();
      notifyListeners();
    }
  }

  void deleteWorkerHours(String id) {
    _workerHours.removeWhere((wh) => wh['id'] == id);
    _save();
    notifyListeners();
  }

  double getTotalHours() {
    return _workerHours.fold(
        0, (sum, wh) => sum + (wh['hoursWorked'] as double));
  }

  double getTotalCost() {
    return _workerHours.fold(
        0, (sum, wh) => sum + (wh['totalCost'] as double));
  }
}