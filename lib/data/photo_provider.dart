import 'dart:async';

import 'package:clean_architecture/ui/home_view_model.dart';
import 'package:flutter/cupertino.dart';

import '../model/Photo.dart';

class PhotoProvider extends InheritedWidget {

  final HomeViewModel homeViewModel;

  const PhotoProvider( {Key? key, required this.homeViewModel, required Widget child}) : super(key: key, child: child);

  static PhotoProvider of(BuildContext context) {
    final PhotoProvider? result = context.dependOnInheritedWidgetOfExactType<PhotoProvider>();
    // 가장 가까운 Generic 타입의 위젯트리를 찾는다.
    assert(result != null, 'No PixabayApi found in context');
    // assert는 경고를 주는 함수다. 조건식이 거짓이면 에러를 발생하면서 뒤에 문자열이 출력된다.

    return result!;
  }


  @override
  bool updateShouldNotify(PhotoProvider oldWidget) {
    return true;
  }
}
