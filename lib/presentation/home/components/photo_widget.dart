import 'package:clean_architecture/domain/model/photo.dart';
import 'package:flutter/material.dart';

class PhotoWidget extends StatelessWidget {
  final Photo photo;

  const PhotoWidget({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        // photo.previewURL의 값이 고정 값이 아니고 photo에 의해 런타임시에 정해지므로 const를 쓸 수 없다.
        image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(photo.previewURL)),
      ),
    );
  }
}
