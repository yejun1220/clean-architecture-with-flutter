import 'package:clean_architecture/note_app/data/data_source/note_db.dart';
import 'package:clean_architecture/note_app/domain/model/note.dart';
import 'package:clean_architecture/note_app/domain/repository/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  NoteDb db;

  NoteRepositoryImpl(this.db);

  @override
  Future<void> deleteNote(Note note) async {
    await db.deleteNote(note);
  }

  @override
  Future<Note?> getNoteById(int id) async {
    return await db.getNoteById(id);
  }

  @override
  Future<List<Note>> getNotes() async {
    return await db.getNotes();
  }

  @override
  Future<void> insertNote(Note note) async {
    return await db.inertNote(note);
  }

  @override
  Future<void> updateNote(Note note) async {
    return await db.updateNote(note);
  }
}
