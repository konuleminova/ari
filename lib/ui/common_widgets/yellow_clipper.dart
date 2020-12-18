import 'package:ari/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'image_asset.dart';

class YellowClipper extends StatelessWidget {
  String imagePath;
  Function onClick;
  bool isClicked;

  YellowClipper(this.imagePath, {this.onClick, this.isClicked});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: Container(
        height: 54.toHeight,
        width: 54.toHeight,
        padding: EdgeInsets.all(18.toHeight),
        child: ImageAssetWidget(
          path: imagePath,
        ),
        decoration: isClicked
            ? BoxDecoration(
                image: DecorationImage(
                image: AssetImage(
                  'assets/images/yellow_clipper.png',
                ),
              ))
            : BoxDecoration(),
      ),
      onTap: () {
        onClick();
      },
    );
  }
}
