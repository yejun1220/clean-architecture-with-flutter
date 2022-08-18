import 'dart:collection';

import 'package:clean_architecture/note_app/domain/model/note.dart';
import 'package:clean_architecture/note_app/domain/repository/note_repository.dart';
import 'package:clean_architecture/note_app/presentation/notes/notes_event.dart';
import 'package:flutter/material.dart';

class NotesViewModel with ChangeNotifier{
  final NoteRepository repository;

  List<Note> _notes = [];
  UnmodifiableListView<Note> get notes => UnmodifiableListView(_notes);

  Note? _recentlyDeletedNote;

  NotesViewModel(this.repository);
  
  void onEvent(NotesEvent event) {
    event.when(loadNotes: _loadNotes, deleteNote: _deleteNote, restoreNote: _restoreNote);
  }

  Future<void> _loadNotes () async {
    List<Note> notes = await repository.getNotes();
    _notes = notes;
    notifyListeners();
  }

  Future<void> _deleteNote (Note note) async {
    await repository.deleteNote(note);
    _recentlyDeletedNote = note;
    await _loadNotes();
  }

  Future<void> _restoreNote (Note note) async {
    if(_recentlyDeletedNote != null) {
      await repository.insertNote(_recentlyDeletedNote!);
      _recentlyDeletedNote = null;
      _loadNotes();

    }
  }
}