import 'dart:async';
import 'dart:collection';

import 'package:clean_architecture/data/data_source/result.dart';
import 'package:clean_architecture/domain/repository/photo_api_repository.dart';
import 'package:clean_architecture/domain/model/photo.dart';
import 'package:clean_architecture/presentation/home/home_ui_event.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  final PhotoApiRepository _photoApiRepository;

  List<Photo> _photos = [];

  UnmodifiableListView<Photo> get photos => UnmodifiableListView(_photos);

  final _eventController = StreamController<HomeUiEvent>();

  Stream<HomeUiEvent> get eventStream => _eventController.stream;

  List<Photo> getPhoto() {
    return _photos;
  }

  HomeViewModel(this._photoApiRepository);

  Future<void> fetch(String query) async {
    final Result<List<Photo>> result = await _photoApiRepository.fetch(query);

    result.when(success: (photo) {
      _photos = photo;
      notifyListeners();
    }, error: (message) {
      _eventController.add(HomeUiEvent.showSnackBar(message));
    });
  }
}
