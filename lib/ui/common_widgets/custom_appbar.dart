import 'dart:convert';

import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/localization/app_localization.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/services/restourant_service.dart';
import 'package:ari/ui/common_widgets/yellow_clipper.dart';
import 'package:ari/ui/views/init.dart';
import 'package:ari/utils/image_config.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari/utils/size_config.dart';

import 'image_asset.dart';

class CustomAppBar extends HookWidget implements PreferredSizeWidget {
  String text;

  CustomAppBar({this.text});

  @override
  Widget build(BuildContext context) {
    var onClickIndex = useState<int>();

    useEffect(() {
      onClickIndex.value = 0;
      return () {};
    }, [onClickIndex]);

//    ApiResponse<RestourantList> apiResponse1 =
//        useFetchRestourants('1', key: UniqueKey());
//    print('API RESPONSE1 ${apiResponse1}');
    // TODO: implement build
    return Stack(
      children: <Widget>[
        AppBar(
          actions: <Widget>[SizedBox()],
          elevation: 0,
          backgroundColor: ThemeColor().greenColor,
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
                      child: YellowClipper(onClickIndex, SEARCH_ASSET, 1,
                          onClick: () {
                        navigationKey.currentState.pushNamed(ROUTE_SEARCH);
                      }),
                    ),
                    Expanded(
                      child: YellowClipper(onClickIndex, PERSON_ASSET, 2,
                          onClick: () {
                        if (SpUtil.getString(SpUtil.token).isEmpty) {
                          navigationKey.currentState.pushNamed(ROUTE_LOGIN);
                        } else {
                          navigationKey.currentState.pushNamed(ROUTE_PROFILE);
                        }
                      }),
                    ),
                    Expanded(child: Container()),
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
                  child: InkWell(
                child: ImageAssetWidget(
                  path: LOGO_ASSET,
                  width: 40.toHeight,
                  height: 40.toHeight,
                ),
                onTap: () {
                  onClickIndex.value = 0;
                  navigationKey.currentState.pushNamed('/');
                },
              ))
            ],
          ),
        ),
        Positioned(
          bottom: 3,
          left: 0,
          // right: 0,
          child: Container(
            width: SizeConfig().screenWidth,
            decoration: BoxDecoration(
                color: ThemeColor().yellowColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            height: 44.toHeight,
            padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
            alignment: Alignment.centerLeft,
            child: Text(
              ApplicationLocalizations.of(context).translate('hello'),
              textAlign: TextAlign.start,
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 11.toFont),
            ),
          ),
        ),
        Positioned(
          child: Container(height: 4, color: ThemeColor().yellowColor),
          bottom: 0,
          left: 0,
          right: 0,
        )
      ],
    );
  }

//final AppBar appBar=
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(85.toHeight);
}
