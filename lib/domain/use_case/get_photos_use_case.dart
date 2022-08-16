import 'dart:math';

import 'package:clean_architecture/data/data_source/result.dart';
import 'package:clean_architecture/domain/model/photo.dart';
import 'package:clean_architecture/domain/repository/photo_api_repository.dart';

class GetPhotosUseCase {
  final PhotoApiRepository repository;

  GetPhotosUseCase(this.repository);

  Future<Result<List<Photo>>> call(String query) async {
    final result = await repository.fetch(query);

    return result.when(success: (photos) {
      return Result.success(photos.sublist(0, min(3, photos.length)));
    }, error: (message) {
      return Result.error(message);
    });
  }
}
