import 'dart:async';

import 'package:clean_architecture/data/photo_api_repository.dart';

import '../model/photo.dart';

class HomeViewModel {
  final PhotoApiRepository _photoApiRepository;
  final _photoStreamController = StreamController<List<Photo>>()..add([]);

  Stream<List<Photo>> get photoStream => _photoStreamController.stream;

  HomeViewModel(this._photoApiRepository);

  Future<void> fetch(String query) async {
    final result = await _photoApiRepository.fetch(query);
    _photoStreamController.add(result);
  }
}
