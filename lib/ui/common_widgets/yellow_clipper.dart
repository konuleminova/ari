import 'package:ari/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'image_asset.dart';

class YellowClipper extends StatelessWidget {
  ValueNotifier onClickIndex;
  String imagePath;
  int index;
  Function onClick;

  YellowClipper(this.onClickIndex, this.imagePath, this.index, {this.onClick});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        child: Container(
          height: 54.toHeight,
          width: 54.toHeight,
          padding: EdgeInsets.all(16.toHeight),
          child: ImageAssetWidget(
            path: imagePath,
          ),
          decoration: onClickIndex.value == index
              ? BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/yellow_clipper.png',
                      ),
                  ))
              : BoxDecoration(),
        ),
      onTap: () {
        onClickIndex.value = index;
        onClick();
      },
    );
  }
}
