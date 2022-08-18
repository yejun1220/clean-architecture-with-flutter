import 'package:clean_architecture/note_app/domain/model/note.dart';
import 'package:sqflite/sqflite.dart';

// =SQL Helpers
class NoteDbHelper {
  Database db;

  NoteDbHelper(this.db);

  Future<Note?> getNoteById(int id) async {
    // SELECT * FROM note WHERE id = 1
    final List<Map<String, dynamic>> json =
        await db.query('Note', where: 'id = ?', whereArgs: [id]);

    if (json.isNotEmpty) {
      return Note.fromJson(json.first);
    }
    return null;
  }

  Future<List<Note>> getNotes() async {
    List<Map<String, dynamic>> json = await db.query('Note');
    return json.map((e) => Note.fromJson(e)).toList();
  }

  Future<void> insertNote(Note note) async {
    await db.insert('note', note.toJson());
  }

  Future<void> updateNote(Note note) async {
    await db
        .update('note', note.toJson(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<void> deleteNote(Note note) async {
    await db
        .delete('note', where: 'id = ?', whereArgs: [note.id]);
  }
}
