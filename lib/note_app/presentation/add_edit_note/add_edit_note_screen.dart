import 'package:clean_architecture/note_app/domain/model/note.dart';
import 'package:clean_architecture/note_app/presentation/add_edit_note/add_edit_note_view_model.dart';
import 'package:clean_architecture/note_app/presentation/add_edit_note/add_edit_note_event.dart';
import 'package:clean_architecture/note_app/presentation/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  const AddEditNoteScreen({Key? key, this.note}) : super(key: key);

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  final List<Color> noteColors = [
    roseBud,
    primrose,
    wisteria,
    skyBlue,
    illusion,
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final viewModel = context.read<AddEditNoteViewModel>();
      viewModel.eventController.listen((event) {
        event.when(saveNote: () {
          Navigator.pop(context, true);
        });
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddEditNoteViewModel>();

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
          top: 48,
        ),
        color: Color(viewModel.color),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: noteColors
                  .map(
                    (color) => InkWell(
                      onTap: () {
                        viewModel.onEvent(AddEditNoteEvent.changeColor(color.value));
                      },
                      child: _backgroundColorButton(
                          color: color, selected: viewModel.color == color.value),
                    ),
                  )
                  .toList(),
            ),
            TextField(
              controller: _titleController,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: darkGrey),
              decoration: const InputDecoration(
                  hintText: '제목을 입력하세요.', border: InputBorder.none),
            ),
            TextField(
              controller: _contentController,
              maxLines: null,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: darkGrey),
              decoration: const InputDecoration(
                  hintText: '내용을 입력하세요.', border: InputBorder.none),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(_titleController.text.isEmpty || _contentController.text.isEmpty) {
            const snackBar = SnackBar(content: Text('제목이나 내용이 비어있습니다.'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          viewModel.onEvent(AddEditNoteEvent.saveNote(
              (widget.note == null ? null : widget.note!.id), _titleController.text, _contentController.text));
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Widget _backgroundColorButton(
      {required Color color, required bool selected}) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5.0,
                spreadRadius: 1.0)
          ],
          border:
              selected ? Border.all(color: Colors.black, width: 2.0) : null),
    );
  }
}
