import 'dart:async';

import 'package:clean_architecture/note_app/domain/model/note.dart';
import 'package:clean_architecture/note_app/domain/repository/note_repository.dart';
import 'package:clean_architecture/note_app/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:clean_architecture/note_app/presentation/add_edit_note/add_edit_note_ui_event.dart';
import 'package:clean_architecture/note_app/presentation/ui/colors.dart';
import 'package:flutter/material.dart';

class AddEditNoteViewModel with ChangeNotifier {
  final NoteRepository repository;

  int _color = roseBud.value;

  final _eventController = StreamController<AddEditNoteUiEvent>.broadcast();

  Stream<AddEditNoteUiEvent> get eventController => _eventController.stream;

  int get color => _color;

  AddEditNoteViewModel(this.repository);

  void onEvent(AddEditNoteEvent event) {
    event.when(
      changeColor: _changeColor,
      saveNote: _saveNote,
    );
  }

  Future<void> _changeColor(int color) async {
    _color = color;
    notifyListeners();
  }

  Future<void> _saveNote(int? id, String title, String content) async {
    if (title.isEmpty || content.isEmpty) {
      _eventController.add(const AddEditNoteUiEvent.showSnackBar('제목이나 내용이 비어있습니다.'));
      return;
    }

    if (id == null) {
      await repository.insertNote(
        Note(
          title: title,
          content: content,
          color: _color,
          timestamp: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    } else {
      await repository.updateNote(
        Note(
          id: id,
          title: title,
          content: content,
          color: _color,
          timestamp: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    }

    _eventController.add(const AddEditNoteUiEvent.saveNote());
  }
}
