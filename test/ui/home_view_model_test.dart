import 'package:clean_architecture/domain/repository/photo_api_repository.dart';
import 'package:clean_architecture/domain/model/photo.dart';
import 'package:clean_architecture/presentation/home/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Stream이 잘 동작해야한다.',
    () async {
      // ui에 로직이 있었다면 HomeViewModel 테스트를 할 수 없었을 것이다.
      final viewModel = HomeViewModel(FakePhotoApiRepository());

      await viewModel.fetch('apple');

      final List<Photo> result = fakeJson.map((e) => Photo.fromJson(e)).toList();

      expect(
          // photoStream에 빈 리스트가 있다.
          viewModel.photos,
          result);
    },
  );
}

class FakePhotoApiRepository extends PhotoApiRepository {
  @override
  Future<List<Photo>> fetch(String query) async {
    // Future.delayed(const Duration(microseconds: 0));

    return fakeJson.map((e) => Photo.fromJson(e)).toList();
  }
}

List<Map<String, dynamic>> fakeJson = [
  {
    "id": 634572,
    "pageURL": "https://pixabay.com/photos/apples-fruits-red-ripe-vitamins-634572/",
    "type": "photo",
    "tags": "apples, fruits, red",
    "previewURL": "https://cdn.pixabay.com/photo/2015/02/13/00/43/apples-634572_150.jpg",
    "previewWidth": 100,
    "previewHeight": 150,
    "webformatURL":
        "https://pixabay.com/get/gc5f1cb4830a4d248f0cda54dd3bb2e0e84c20ff430e84e536b03724056c2a947beae9206c6cab39834c8706a30ead647_640.jpg",
    "webformatWidth": 427,
    "webformatHeight": 640,
    "largeImageURL":
        "https://pixabay.com/get/gf1e840ffabfe51608ebe10573549ea3910de26a1c2199ac0717a169b2a46d094638cd801bbeace36a1bce85fd306512d3b13f1eed58eb352ecce9d293a7b837e_1280.jpg",
    "imageWidth": 3345,
    "imageHeight": 5017,
    "imageSize": 811238,
    "views": 408742,
    "downloads": 234279,
    "collections": 2947,
    "likes": 2293,
    "comments": 180,
    "user_id": 752536,
    "user": "Desertrose7",
    "userImageURL": "https://cdn.pixabay.com/user/2016/03/14/13-25-18-933_250x250.jpg"
  },
  {
    "id": 4352072,
    "pageURL": "https://pixabay.com/photos/new-york-usa-nyc-ny-manhattan-4352072/",
    "type": "photo",
    "tags": "new york, usa, nyc",
    "previewURL": "https://cdn.pixabay.com/photo/2019/07/21/07/12/new-york-4352072_150.jpg",
    "previewWidth": 150,
    "previewHeight": 90,
    "webformatURL":
        "https://pixabay.com/get/g3ce62fc50f9bb27efd3471b5cde19bcc051567385b8d0674509491ca6b14aff9f8c261113f368cb1498ca2aedd563e0693cebeb48ba9a9e94c88e6d429b3fad6_640.jpg",
    "webformatWidth": 640,
    "webformatHeight": 385,
    "largeImageURL":
        "https://pixabay.com/get/g49f7e2c12f45abc75250369cc74e21912d2e35c1209384cc020a20129d32865a21fac9f8763647a907a958eb93646542806678bd2162b35dc24ef69f809901dc_1280.jpg",
    "imageWidth": 5000,
    "imageHeight": 3010,
    "imageSize": 3526990,
    "views": 106867,
    "downloads": 83828,
    "collections": 3028,
    "likes": 182,
    "comments": 33,
    "user_id": 1131094,
    "user": "Leonhard_Niederwimmer",
    "userImageURL": "https://cdn.pixabay.com/user/2020/05/13/18-42-49-177_250x250.jpg"
  },
];
