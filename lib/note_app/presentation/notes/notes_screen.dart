import 'package:clean_architecture/note_app/domain/model/note.dart';
import 'package:clean_architecture/note_app/presentation/add_edit_note/add_edit_note_screen.dart';
import 'package:clean_architecture/note_app/presentation/notes/components/note_item.dart';
import 'package:clean_architecture/note_app/presentation/ui/colors.dart';
import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your note",
          style: TextStyle(fontSize: 30),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.sort),
          ),
        ],
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditNoteScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [
          NoteItem(
            note: Note(
                title: 'test',
                content: 'test',
                color: wisteria.value,
                timestamp: 1),
          ),
        ]),
      ),
    );
  }
}
