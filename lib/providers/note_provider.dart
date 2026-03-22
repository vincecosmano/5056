import 'package:flutter/foundation.dart';

class Note {
  String id;
  String content;

  Note({required this.id, required this.content});
}

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  void add(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void update(String id, String content) {
    final noteIndex = _notes.indexWhere((note) => note.id == id);
    if (noteIndex >= 0) {
      _notes[noteIndex].content = content;
      notifyListeners();
    }
  }

  void delete(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  void clearAllNotes() {
    _notes.clear();
    notifyListeners();
  }
}
