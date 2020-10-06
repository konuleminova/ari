import 'package:ari/ui/utils/image_asset.dart';
import 'package:flutter/material.dart';
import '../utils/size_config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF5fb640),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ImageAssetWidget(
                      path: BASKET,
                    ),
                    SizedBox(
                      width: 24.toWidth,
                    ),
                    ImageAssetWidget(
                      path: SEARCH,
                    ),
                    SizedBox(
                      width: 24.toWidth,
                    ),
                    ImageAssetWidget(
                      path: PERSON,
                    ),
                  ],
                ),
                flex: 3,
              ),
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                  child: ImageAssetWidget(
                path: LOGO,
                width: 40.toHeight,
                height: 40.toHeight,
              ))
            ],
          ),
        ),
        Positioned(
          bottom: -10,
          left: 0,
          right: 0,
          child: Container(
              decoration: BoxDecoration(
                  color: Color(0xfffccd13),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              height: 44.toHeight,
              child: Center(
                child: Text(
                  'Доброе утро Ильхам, сегодня в Баку 23 оС, отличная погода...',
                  textAlign: TextAlign.center,
                ),
              )),
        )
      ],
    );
  }

//final AppBar appBar=
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(85.toHeight);
}
