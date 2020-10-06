import 'package:flutter/cupertino.dart';
import 'size_config.dart';

class ImageAssetWidget extends StatelessWidget {
  final String path;
  final width;
  final height;

  ImageAssetWidget({this.path, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Image.asset(
      path,
      height: width ?? 16.toHeight,
      width: height ?? 16.toHeight,
    );
  }
}

const BASE_ASSET = 'assets/images/';

const SEARCH = BASE_ASSET + "search.png";
const BASKET = BASE_ASSET + "basket.png";
const PERSON = BASE_ASSET + "person.png";
const LOGO = BASE_ASSET + 'logo.png';
