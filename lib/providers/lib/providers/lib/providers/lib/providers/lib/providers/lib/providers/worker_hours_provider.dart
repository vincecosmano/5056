import 'package:flutter/material.dart';

class WorkerHoursProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _workerHours = [];
  bool _isClockedIn = false;

  List<Map<String, dynamic>> get workerHours => _workerHours;
  bool get isClockedIn => _isClockedIn;

  void addWorkerHours(Map<String, dynamic> hours) {
    _workerHours.add(hours);
    notifyListeners();
  }

  void updateWorkerHours(int index, Map<String, dynamic> hours) {
    _workerHours[index] = hours;
    notifyListeners();
  }

  void deleteWorkerHours(int index) {
    _workerHours.removeAt(index);
    notifyListeners();
  }

  void clearWorkerHours() {
    _workerHours.clear();
    notifyListeners();
  }

  void toggleClockIn() {
    _isClockedIn = !_isClockedIn;
    notifyListeners();
  }
}
