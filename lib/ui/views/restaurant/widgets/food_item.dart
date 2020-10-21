import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari/utils/size_config.dart';

class FoodItem extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.toHeight,horizontal: 8.toWidth),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.3)))),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Some text'),
                  Text('Some text'),
                  SizedBox(
                    height: 16.toHeight,
                  ),
                  Container(
                    width: 130.toWidth,
                    padding: EdgeInsets.symmetric(vertical: 4.toHeight,horizontal: 8.toWidth),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('16.45'),
                        Icon(Icons.shopping_basket)
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ],
              ),
              padding: EdgeInsets.only(left: 16.toWidth),
            ),
            flex: 3,
          ),
          SizedBox(
            width: 16.toWidth,
          ),
          Expanded(
            flex: 2,
            child: ClipRRect(
              child: Image.network(
                  'https://bees.az/___entcpanel/uploads/d3271c371aae25d4f8c747912391ce93_206431.png'),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
