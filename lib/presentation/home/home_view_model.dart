import 'dart:async';
import 'dart:collection';

import 'package:clean_architecture/domain/repository/photo_api_repository.dart';
import 'package:clean_architecture/domain/model/photo.dart';
import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  final PhotoApiRepository _photoApiRepository;

  List<Photo> _photos = [];

  UnmodifiableListView<Photo> get photos => UnmodifiableListView(_photos);

  List<Photo> getPhoto() {
    return _photos;
  }

  HomeViewModel(this._photoApiRepository);

  Future<void> fetch(String query) async {
    final result = await _photoApiRepository.fetch(query);
    _photos = result;
    notifyListeners();
  }
}
