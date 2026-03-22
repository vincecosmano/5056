import 'package:flutter/material.dart';

class ProjectProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _projects = [];

  List<Map<String, dynamic>> get projects => _projects;

  void addProject(Map<String, dynamic> project) {
    _projects.add(project);
    notifyListeners();
  }

  void updateProject(int index, Map<String, dynamic> project) {
    _projects[index] = project;
    notifyListeners();
  }

  void deleteProject(int index) {
    _projects.removeAt(index);
    notifyListeners();
  }

  void clearProjects() {
    _projects.clear();
    notifyListeners();
  }
}
