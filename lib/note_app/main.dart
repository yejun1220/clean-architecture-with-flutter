import 'package:clean_architecture/note_app/di/provider_setup.dart';
import 'package:clean_architecture/note_app/presentation/notes/notes_screen.dart';
import 'package:clean_architecture/note_app/presentation/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // 플랫폼 채널의 위젯 바인딩을 보장
  WidgetsFlutterBinding.ensureInitialized();

  final providers = await getProviders();
  runApp(
    MultiProvider(
      providers: providers,
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
        floatingActionButtonTheme: Theme.of(context).floatingActionButtonTheme.copyWith(
              backgroundColor: lightBlue,
              foregroundColor: darkGrey,
            ),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: darkGrey,
            ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
            ),
      ),
      home: const NotesScreen(),
    );
  }
}
