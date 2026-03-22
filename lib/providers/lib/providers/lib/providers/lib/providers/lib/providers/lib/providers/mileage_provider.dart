import 'package:flutter/material.dart';

class MileageProvider with ChangeNotifier {
  List<Map<String, dynamic>> _mileages = [];

  List<Map<String, dynamic>> get mileages => _mileages;

  void addMileage(double distance, DateTime date, String description, double ratePerKm) {
    _mileages.add({
      'id': DateTime.now().toString(),
      'distance': distance,
      'date': date,
      'description': description,
      'ratePerKm': ratePerKm,
      'totalCost': distance * ratePerKm,
    });
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
      notifyListeners();
    }
  }

  void deleteMileage(String id) {
    _mileages.removeWhere((mileage) => mileage['id'] == id);
    notifyListeners();
  }

  double getTotalMileage() {
    return _mileages.fold(0, (sum, mileage) => sum + (mileage['distance'] as double));
  }

  double getTotalMileageCost() {
    return _mileages.fold(0, (sum, mileage) => sum + (mileage['totalCost'] as double));
  }
}
