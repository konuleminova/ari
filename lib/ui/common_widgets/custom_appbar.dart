import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/ui/views/init.dart';
import 'package:ari/utils/image_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari/utils/size_config.dart';

import 'image_asset.dart';

class CustomAppBar extends HookWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    var onClickIndex = useState<int>(0);
    useEffect(() {
      onClickIndex.value = 0;
      return () {};
    }, [onClickIndex]);
    // TODO: implement build
    return Stack(
      children: <Widget>[
        AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF5fb640),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child:
                          _iconItem(onClickIndex, BASKET_ASSET, 0, onClick: () {
                        navigationKey.currentState.pushNamed('/');
                      }),
                    ),
                    Expanded(
                      child:
                          _iconItem(onClickIndex, SEARCH_ASSET, 1, onClick: () {
                        navigationKey.currentState.pushNamed(ROUTE_SEARCH);
                      }),
                    ),
                    Expanded(
                      child:
                          _iconItem(onClickIndex, PERSON_ASSET, 2, onClick: () {
                        navigationKey.currentState.pushNamed(ROUTE_PROFILE);
                      }),
                    )
                  ],
                ),
                width: 200,
                margin: EdgeInsets.only(left: 8.toWidth),
                alignment: Alignment.bottomCenter,
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: 54.toHeight,
                ),
              ),
              Expanded(
                  child: ImageAssetWidget(
                path: LOGO_ASSET,
                width: 40.toHeight,
                height: 40.toHeight,
              ))
            ],
          ),
        ),
        Positioned(
          bottom: 0,
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

  _iconItem(ValueNotifier onClickIndex, String imagePath, int index,
      {Function onClick}) {
    return GestureDetector(
      child: Container(
        height: 54.toHeight,
        width: 54.toHeight,
        padding: EdgeInsets.all(18.toHeight),
        child: ImageAssetWidget(
          path: imagePath,
        ),
        decoration: onClickIndex.value == index
            ? BoxDecoration(
                image: DecorationImage(
                image: AssetImage('assets/images/yellow_clipper.png'),
              ))
            : null,
      ),
      onTap: () {
        onClickIndex.value = index;
        onClick();
      },
    );
  }
}
