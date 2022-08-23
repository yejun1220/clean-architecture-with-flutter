import 'package:clean_architecture/note_app/domain/model/note.dart';
import 'package:clean_architecture/note_app/domain/repository/note_repository.dart';
import 'package:clean_architecture/note_app/domain/use_case/get_notes_use_case.dart';
import 'package:clean_architecture/note_app/domain/util/note_order.dart';
import 'package:clean_architecture/note_app/domain/util/order_type.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_notes_use_case_test.mocks.dart';

@GenerateMocks([NoteRepository])
void main() {
  test('정렬 기능이 잘 동해야 한다.', () async {
    final repository = MockNoteRepository();
    final getNotes = GetNotesUseCase(repository);

    // 동작 정의
    when(repository.getNotes()).thenAnswer((_) async => [
          Note(title: 'title1', content: 'content1', color: 1, timestamp: 1),
          Note(title: 'title2', content: 'content2', color: 2, timestamp: 2),
        ]);

    // 날짜 내림차순
    List<Note> result = await getNotes(const NoteOrder.date(OrderType.descending()));
    expect(result, isA<List<Note>>());
    expect(result.first.timestamp, 2);
    verify(repository.getNotes());

    // 날짜 오름순
    result = await getNotes(const NoteOrder.date(OrderType.ascending()));
    expect(result.first.timestamp, 1);
    verify(repository.getNotes());

    // 제목 내림차순
    result = await getNotes(const NoteOrder.title(OrderType.descending()));
    expect(result.first.title, 'title2');
    verify(repository.getNotes());

    // 제목 오름차
    result = await getNotes(const NoteOrder.title(OrderType.ascending()));
    expect(result.first.title, 'title1');
    verify(repository.getNotes());

    // 색깔 내림차순
    result = await getNotes(const NoteOrder.color(OrderType.descending()));
    expect(result.first.color, 2);
    verify(repository.getNotes());

    // 색깔 오름차순
    result = await getNotes(const NoteOrder.color(OrderType.ascending()));
    expect(result.first.color, 1);
    verify(repository.getNotes());

    verifyNoMoreInteractions(repository);
  });
}
