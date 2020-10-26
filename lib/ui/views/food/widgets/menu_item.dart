import 'package:ari/business_logic/models/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:ari/utils/size_config.dart';

class MenuItem extends StatelessWidget {
 final Menu menu;

 MenuItem({this.menu});

 @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 40.toHeight,
      padding: EdgeInsets.all(8.toWidth),
      child: Text(menu.name),
      margin: EdgeInsets.symmetric(horizontal: 8.toWidth),
    );
  }
}
