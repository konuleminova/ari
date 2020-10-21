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
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Text('Some text'),
                Text('Some text'),
                SizedBox(
                  height: 16.toHeight,
                ),
                Container(
                  padding: EdgeInsets.all(4.toWidth),
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
                )
              ],
            ),
            flex: 3,
          ),
          SizedBox(
            width: 16.toWidth,
          ),
          Expanded(
            child: ClipRRect(
              child: Image.network(
                  'https://bees.az/___entcpanel/uploads/d3271c371aae25d4f8c747912391ce93_206431.png'),
              borderRadius: BorderRadius.circular(10),
            ),
          )
        ],
      ),
    );
  }
}
