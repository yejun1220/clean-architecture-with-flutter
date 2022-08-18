import 'package:clean_architecture/note_app/domain/model/note.dart';
import 'package:clean_architecture/note_app/domain/repository/note_repository.dart';

class AddNote {
  final NoteRepository repository;

  AddNote(this.repository);

  Future<void> call(Note note) async {
    await repository.insertNote(note);
  }
}