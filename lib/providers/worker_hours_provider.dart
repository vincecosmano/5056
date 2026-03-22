import 'package:flutter/material.dart';
class WorkerHoursProvider with ChangeNotifier {
  List<Map<String, dynamic>> _workerHours = [];

  List<Map<String, dynamic>> get workerHours => _workerHours;

  void addWorkerHours(String workerId, double hoursWorked, DateTime date, String description, double hourlyRate) {
    _workerHours.add({'id': DateTime.now().toString(), 'workerId': workerId, 'hoursWorked': hoursWorked, 'date': date, 'description': description, 'hourlyRate': hourlyRate, 'totalCost': hoursWorked * hourlyRate});
    notifyListeners();
  }

  void updateWorkerHours(String id, String workerId, double hoursWorked, DateTime date, String description, double hourlyRate) {
    final index = _workerHours.indexWhere((wh) => wh['id'] == id);
    if (index != -1) {
      _workerHours[index] = {'id': id, 'workerId': workerId, 'hoursWorked': hoursWorked, 'date': date, 'description': description, 'hourlyRate': hourlyRate, 'totalCost': hoursWorked * hourlyRate};
      notifyListeners();
    }
  }

  void deleteWorkerHours(String id) {
    _workerHours.removeWhere((wh) => wh['id'] == id);
    notifyListeners();
  }

  double getTotalHours() {
    return _workerHours.fold(0, (sum, wh) => sum + (wh['hoursWorked'] as double));
  }

  double getTotalCost() {
    return _workerHours.fold(0, (sum, wh) => sum + (wh['totalCost'] as double));
  }
}