import 'package:clean_architecture/image_search_app/data/data_source/pixabay_api.dart';
import 'package:clean_architecture/image_search_app/data/repository/photo_api_repository_impl.dart';
import 'package:clean_architecture/image_search_app/di/provider_setup.dart';
import 'package:clean_architecture/image_search_app/domain/use_case/get_photos_use_case.dart';
import 'package:clean_architecture/image_search_app/presentation/home/home_screen.dart';
import 'package:clean_architecture/image_search_app/presentation/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

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
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
