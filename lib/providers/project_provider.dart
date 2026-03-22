import 'package:flutter/foundation.dart';

class Project {
  String id;
  String name;
  String description;
  DateTime startDate;
  DateTime? endDate;
  String status;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    this.endDate,
    required this.status,
  });
}

class ProjectProvider with ChangeNotifier {
  List<Project> _projects = [];

  List<Project> get projects => _projects;

  void add(Project project) {
    _projects.add(project);
    notifyListeners();
  }

  void update(Project project) {
    final index = _projects.indexWhere((p) => p.id == project.id);
    if (index >= 0) {
      _projects[index] = project;
      notifyListeners();
    }
  }

  void delete(String id) {
    _projects.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}
