import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Note {
  String id;
  String title;
  String content;

  Note({required this.id, required this.title, required this.content});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
      };

  factory Note.fromJson(Map<String, dynamic> j) => Note(
        id: j['id'] as String,
        title: (j['title'] as String?) ?? '',
        content: (j['content'] as String?) ?? '',
      );
}

class NoteProvider with ChangeNotifier {
  static const _key = 'notes';
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  NoteProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw != null) {
      final list = jsonDecode(raw) as List<dynamic>;
      _notes = list
          .map((e) => Note.fromJson(e as Map<String, dynamic>))
          .toList();
      notifyListeners();
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_notes.map((n) => n.toJson()).toList());
    await prefs.setString(_key, encoded);
  }

  void add(Note note) {
    _notes.add(note);
    _save();
    notifyListeners();
  }

  void update(String id, String content) {
    final noteIndex = _notes.indexWhere((note) => note.id == id);
    if (noteIndex >= 0) {
      _notes[noteIndex].content = content;
      _save();
      notifyListeners();
    }
  }

  void updateNote(String id, {String? title, String? content}) {
    final idx = _notes.indexWhere((n) => n.id == id);
    if (idx >= 0) {
      if (title != null) _notes[idx].title = title;
      if (content != null) _notes[idx].content = content;
      _save();
      notifyListeners();
    }
  }

  void delete(String id) {
    _notes.removeWhere((note) => note.id == id);
    _save();
    notifyListeners();
  }

  void clearAllNotes() {
    _notes.clear();
    _save();
    notifyListeners();
  }
}
