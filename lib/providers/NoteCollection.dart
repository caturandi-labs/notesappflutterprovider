import 'package:flutter/material.dart';
import 'package:notesapp/models/Note.dart';

class NoteCollection extends ChangeNotifier
{
  final List<Note> _notes = [];
  get count {
    return _notes.length;
  }

  get allNotes => _notes;

  Note getNote(String id) {
    return _notes.where((note) => note.id == id).first;
  }

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void removeNote(String id) {
    _notes.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void updateNote(String id, String body) {

    var currentNote = _notes.where((note) => note.id == id).first;
    currentNote.body = body;

    notifyListeners();
  }
}
