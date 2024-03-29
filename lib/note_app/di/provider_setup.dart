import 'package:clean_architecture/note_app/data/data_source/note_db_helper.dart';
import 'package:clean_architecture/note_app/data/repository/note_repository_impl.dart';
import 'package:clean_architecture/note_app/domain/repository/note_repository.dart';
import 'package:clean_architecture/note_app/domain/use_case/add_note_use_case.dart';
import 'package:clean_architecture/note_app/domain/use_case/delete_note_use_case.dart';
import 'package:clean_architecture/note_app/domain/use_case/get_note_use_case.dart';
import 'package:clean_architecture/note_app/domain/use_case/get_notes_use_case.dart';
import 'package:clean_architecture/note_app/domain/use_case/update_note_use_case.dart';
import 'package:clean_architecture/note_app/domain/use_case/use_cases.dart';
import 'package:clean_architecture/note_app/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:clean_architecture/note_app/presentation/notes/notes_view_model.dart';
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
    await db.execute('CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT, color INTEGER, timestamp INTEGER)');
  });

  NoteDbHelper noteDbHelper = NoteDbHelper(database);
  NoteRepository repository = NoteRepositoryImpl(noteDbHelper);
  UseCases useCases = UseCases(
    addNote: AddNoteUseCase(repository),
    deleteNote: DeleteNoteUseCase(repository),
    getNote: GetNoteUseCase(repository),
    getNotes: GetNotesUseCase(repository),
    updateNote: UpdateNoteUseCase(repository),
  );
  NotesViewModel notesViewModel = NotesViewModel(useCases);
  AddEditNoteViewModel addEditNoteViewModel = AddEditNoteViewModel(repository);

  return [
    /** AddEditNoteViewModel 매번 생성 */
    // Provider(
    //   create: (_) => NoteRepositoryImpl(noteDbHelper),
    // ),
    ChangeNotifierProvider(
      create: (_) => notesViewModel,
    ),
    ChangeNotifierProvider(
      create: (_) => addEditNoteViewModel,
    )
  ];
}
