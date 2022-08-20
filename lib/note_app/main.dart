import 'package:clean_architecture/image_search_app/di/provider_setup.dart';
import 'package:clean_architecture/note_app/presentation/notes/notes_screen.dart';
import 'package:clean_architecture/note_app/presentation/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: globalProviders,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        backgroundColor: darkGrey,
        canvasColor: darkGrey,
        floatingActionButtonTheme:
          Theme.of(context).floatingActionButtonTheme.copyWith(
            backgroundColor: lightBlue,
            foregroundColor: darkGrey
          ),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
          backgroundColor: darkGrey,
        )
      ),
      home: const NotesScreen(),
    );
  }
}
