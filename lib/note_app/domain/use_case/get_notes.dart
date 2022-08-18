import 'package:clean_architecture/note_app/domain/model/note.dart';
import 'package:clean_architecture/note_app/domain/repository/note_repository.dart';

class GetNotes {
  final NoteRepository repository;

  GetNotes(this.repository);

  Future<List<Note>> call() async {
    return await repository.getNotes();
  }
}