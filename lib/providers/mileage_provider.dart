import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MileageProvider with ChangeNotifier {
  static const _key = 'mileage';
  List<Map<String, dynamic>> _mileages = [];

  List<Map<String, dynamic>> get mileages => _mileages;

  MileageProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw != null) {
      final list = jsonDecode(raw) as List<dynamic>;
      _mileages = list.map((e) {
        final m = Map<String, dynamic>.from(e as Map);
        m['distance'] = (m['distance'] as num).toDouble();
        m['ratePerKm'] = (m['ratePerKm'] as num).toDouble();
        m['totalCost'] = (m['totalCost'] as num).toDouble();
        m['date'] = DateTime.parse(m['date'] as String);
        return m;
      }).toList();
      notifyListeners();
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final serializable = _mileages.map((m) {
      final copy = Map<String, dynamic>.from(m);
      if (copy['date'] is DateTime) {
        copy['date'] = (copy['date'] as DateTime).toIso8601String();
      }
      return copy;
    }).toList();
    await prefs.setString(_key, jsonEncode(serializable));
  }

  void addMileage(double distance, DateTime date, String description, double ratePerKm) {
    _mileages.add({
      'id': DateTime.now().toString(),
      'distance': distance,
      'date': date,
      'description': description,
      'ratePerKm': ratePerKm,
      'totalCost': distance * ratePerKm,
    });
    _save();
    notifyListeners();
  }

  void updateMileage(String id, double distance, DateTime date, String description, double ratePerKm) {
    final index = _mileages.indexWhere((mileage) => mileage['id'] == id);
    if (index != -1) {
      _mileages[index] = {
        'id': id,
        'distance': distance,
        'date': date,
        'description': description,
        'ratePerKm': ratePerKm,
        'totalCost': distance * ratePerKm,
      };
      _save();
      notifyListeners();
    }
  }

  void deleteMileage(String id) {
    _mileages.removeWhere((mileage) => mileage['id'] == id);
    _save();
    notifyListeners();
  }

  double getTotalMileage() {
    return _mileages.fold(0, (sum, mileage) => sum + (mileage['distance'] as double));
  }

  double getTotalMileageCost() {
    return _mileages.fold(0, (sum, mileage) => sum + (mileage['totalCost'] as double));
  }
}