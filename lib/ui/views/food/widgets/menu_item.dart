import 'package:ari/business_logic/models/menu.dart';
import 'package:ari/utils/size_config.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final Menu menu;

  MenuItem({this.menu});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Container(
        height: 40.toHeight,
        decoration: BoxDecoration(
            color: menu.selected ? ThemeColor().grey1.withOpacity(0.5) : Colors.white,
            borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.all(8.toWidth),
        child: Center(
          child: Text(
            menu.name ?? 'no item',
            style: TextStyle(color: ThemeColor().greyColor),
          ),
        ),
        margin: EdgeInsets.symmetric(horizontal: 8.toWidth),
      ),
      padding: EdgeInsets.all(6.toWidth),
    );
  }
}
