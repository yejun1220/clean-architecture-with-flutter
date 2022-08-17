import 'package:clean_architecture/image_search_app/data/data_source/result.dart';
import 'package:clean_architecture/image_search_app/domain/model/photo.dart';

abstract class PhotoApiRepository {
  Future<Result<List<Photo>>> fetch(String query);
}
