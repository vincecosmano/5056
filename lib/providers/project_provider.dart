import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'status': status,
      };

  factory Project.fromJson(Map<String, dynamic> j) => Project(
        id: j['id'] as String,
        name: j['name'] as String,
        description: (j['description'] as String?) ?? '',
        startDate: DateTime.parse(j['startDate'] as String),
        endDate: j['endDate'] != null
            ? DateTime.parse(j['endDate'] as String)
            : null,
        status: (j['status'] as String?) ?? 'Active',
      );
}

class ProjectProvider with ChangeNotifier {
  static const _key = 'projects';
  List<Project> _projects = [];

  List<Project> get projects => _projects;

  ProjectProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw != null) {
      final list = jsonDecode(raw) as List<dynamic>;
      _projects = list
          .map((e) => Project.fromJson(e as Map<String, dynamic>))
          .toList();
      notifyListeners();
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        _key, jsonEncode(_projects.map((p) => p.toJson()).toList()));
  }

  void add(Project project) {
    _projects.add(project);
    _save();
    notifyListeners();
  }

  void update(Project project) {
    final index = _projects.indexWhere((p) => p.id == project.id);
    if (index >= 0) {
      _projects[index] = project;
      _save();
      notifyListeners();
    }
  }

  void delete(String id) {
    _projects.removeWhere((p) => p.id == id);
    _save();
    notifyListeners();
  }
}
