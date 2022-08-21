import 'package:clean_architecture/note_app/data/data_source/note_db_helper.dart';
import 'package:clean_architecture/note_app/data/repository/NoteRepositoryImpl.dart';
import 'package:clean_architecture/note_app/domain/repository/note_repository.dart';
import 'package:clean_architecture/note_app/presentation/add_edit_note/AddEditNoteViewModel.dart';
import 'package:clean_architecture/note_app/presentation/notes/notes_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sqflite/sqflite.dart';

// // 전체적인 Provider 를 관리
// List<SingleChildWidget> globalProviders = [
//   ...independentModels,
//   ...dependentModels,
//   ...viewModels,
// ];
//
// // 독립적인 Provider 를 관리
// List<SingleChildWidget> independentModels = [];
//
// // 의존성 있는 객체
// List<SingleChildWidget> dependentModels = [];
//
// // ViewModel
// List<SingleChildWidget> viewModels = [];

Future<List<SingleChildWidget>> getProviders() async {
  Database database = await openDatabase('notes_db', version: 1, onCreate: (db, version) async {
    await db.execute('CREATE TABLE (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, color INTEGER, timestamp INTEGER');
  });

  NoteDbHelper noteDbHelper = NoteDbHelper(database);
  NoteRepository repository = NoteRepositoryImpl(noteDbHelper);
  NotesViewModel notesViewModel = NotesViewModel(repository);
  AddEditNoteViewModel addEditNoteViewModel = AddEditNoteViewModel(repository);

  return [
    ChangeNotifierProvider(
      create: (_) => notesViewModel,
    ),
    ChangeNotifierProvider(
      create: (_) => addEditNoteViewModel,
    )
  ];
}
