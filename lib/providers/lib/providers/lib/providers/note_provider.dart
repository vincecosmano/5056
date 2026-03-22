import 'package:flutter/material.dart';

class NoteProvider with ChangeNotifier {
  List<Map<String, dynamic>> _notes = [];

  List<Map<String, dynamic>> get notes => _notes;

  void addNote(String title, String content) {
    _notes.add({
      'id': DateTime.now().toString(),
      'title': title,
      'content': content,
      'createdAt': DateTime.now(),
    });
    notifyListeners();
  }

  void updateNote(String id, String title, String content) {
    final index = _notes.indexWhere((note) => note['id'] == id);
    if (index != -1) {
      _notes[index] = {
        'id': id,
        'title': title,
        'content': content,
        'createdAt': _notes[index]['createdAt'],
      };
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note['id'] == id);
    notifyListeners();
  }

  void clearAllNotes() {
    _notes.clear();
    notifyListeners();
  }
}
Click "Commit new file"
STEP 2: ADD FILE - project_provider.dart
Click "Add file" → "Create new file"
Name: lib/providers/project_provider.dart
Paste this code:
Dart
import 'package:flutter/material.dart';

class ProjectProvider with ChangeNotifier {
  List<Map<String, dynamic>> _projects = [];

  List<Map<String, dynamic>> get projects => _projects;

  void addProject(String name, String description, DateTime startDate, DateTime? endDate) {
    _projects.add({
      'id': DateTime.now().toString(),
      'name': name,
      'description': description,
      'startDate': startDate,
      'endDate': endDate,
      'status': 'Active',
    });
    notifyListeners();
  }

  void updateProject(String id, String name, String description, DateTime startDate, DateTime? endDate) {
    final index = _projects.indexWhere((project) => project['id'] == id);
    if (index != -1) {
      _projects[index] = {
        'id': id,
        'name': name,
        'description': description,
        'startDate': startDate,
        'endDate': endDate,
        'status': _projects[index]['status'],
      };
      notifyListeners();
    }
  }

  void deleteProject(String id) {
    _projects.removeWhere((project) => project['id'] == id);
    notifyListeners();
  }

  void setProjectStatus(String id, String status) {
    final index = _projects.indexWhere((project) => project['id'] == id);
    if (index != -1) {
      _projects[index]['status'] = status;
      notifyListeners();
    }
  }
}
