import 'package:clean_architecture/note_app/domain/model/note.dart';
import 'package:clean_architecture/note_app/domain/use_case/use_cases.dart';
import 'package:clean_architecture/note_app/domain/util/note_order.dart';
import 'package:clean_architecture/note_app/domain/util/order_type.dart';
import 'package:clean_architecture/note_app/presentation/notes/notes_event.dart';
import 'package:clean_architecture/note_app/presentation/notes/notes_state.dart';
import 'package:flutter/material.dart';

class NotesViewModel with ChangeNotifier {
  final UseCases useCases;

  NotesState _state = NotesState(
    notes: [],
    noteOrder: const NoteOrder.date(OrderType.descending()),
    isOrderSectionVisible: false,
  );

  NotesState get state => _state;

  Note? _recentlyDeletedNote;

  NotesViewModel(this.useCases) {
    _loadNotes();
  }

  void onEvent(NotesEvent event) {
    event.when(
      loadNotes: _loadNotes,
      deleteNote: _deleteNote,
      restoreNote: _restoreNote,
      changeOrder: _changeOrder,
      toggleOrderSection: _toggleOrderSection,
    );
  }

  Future<void> _loadNotes() async {
    List<Note> notes = await useCases.getNotes(state.noteOrder);
    _state = _state.copyWith(notes: notes);
    notifyListeners();
  }

  Future<void> _deleteNote(Note note) async {
    await useCases.deleteNote(note);
    _recentlyDeletedNote = note;
    await _loadNotes();
  }

  Future<void> _restoreNote(Note note) async {
    if (_recentlyDeletedNote != null) {
      await useCases.addNote(_recentlyDeletedNote!);
      _recentlyDeletedNote = null;
      _loadNotes();
    }
  }

  void _changeOrder(noteOrder) {
    _state = _state.copyWith(noteOrder: noteOrder);
    _loadNotes();
  }

  void _toggleOrderSection() {
    _state = _state.copyWith(isOrderSectionVisible: !_state.isOrderSectionVisible);
    notifyListeners();
  }
}
