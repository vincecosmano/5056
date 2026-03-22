import 'package:flutter/material.dart';

class MileageProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _mileageRecords = [];

  List<Map<String, dynamic>> get mileageRecords => _mileageRecords;

  void addMileage(Map<String, dynamic> mileage) {
    _mileageRecords.add(mileage);
    notifyListeners();
  }

  void updateMileage(int index, Map<String, dynamic> mileage) {
    _mileageRecords[index] = mileage;
    notifyListeners();
  }

  void deleteMileage(int index) {
    _mileageRecords.removeAt(index);
    notifyListeners();
  }

  void clearMileage() {
    _mileageRecords.clear();
    notifyListeners();
  }
}
