import 'dart:convert';

import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/localization/app_localization.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/services/restourant_service.dart';
import 'package:ari/ui/common_widgets/yellow_clipper.dart';
import 'package:ari/ui/provider/app_bar/app_bar_action.dart';
import 'package:ari/ui/provider/app_bar/app_bar_state.dart';
import 'package:ari/ui/views/init.dart';
import 'package:ari/utils/image_config.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari/utils/size_config.dart';

import 'image_asset.dart';

class CustomAppBar extends HookWidget implements PreferredSizeWidget {
  CustomAppBar();

  @override
  Widget build(BuildContext context) {
    final store = getAppBarStore();
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
                      child: YellowClipper(
                        SEARCH_ASSET,
                        onClick: () {
                          if (store.state.index != 1) {
                            store.dispatch(AppBarAction(index: 1));
                            navigationKey.currentState.pushNamed(ROUTE_SEARCH);
                          }
                        },
                        isClicked: store.state.index == 1 ? true : false,
                      ),
                    ),
                    Expanded(
                      child: YellowClipper(
                        PERSON_ASSET,
                        onClick: () {
                          if (store.state.index != 2) {
                            store.dispatch(AppBarAction(index: 2));
                            if (SpUtil.getString(SpUtil.token).isEmpty) {
                              navigationKey.currentState.pushNamed(ROUTE_LOGIN);
                            } else {
                              navigationKey.currentState
                                  .pushNamed(ROUTE_PROFILE);
                            }
                          }
                        },
                        isClicked: store.state.index == 2 ? true : false,
                      ),
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
              store.state.message ??'',
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
