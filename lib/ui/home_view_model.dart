import 'dart:async';

import '../data/api.dart';
import '../model/Photo.dart';

class HomeViewModel {
  final PixabayApi pixabayApi;
  final _photoStreamController = StreamController<List<Photo>>()..add([]);

  Stream<List<Photo>> get photoStream => _photoStreamController.stream;

  HomeViewModel(this.pixabayApi);

  Future<void> fetch(String query) async {
    final result = await pixabayApi.fetch(query);
    _photoStreamController.add(result);
  }
}
