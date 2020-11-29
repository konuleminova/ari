import 'package:ari/business_logic/models/food.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari/utils/size_config.dart';

class FoodItem extends StatelessWidget {
  Food item;

  FoodItem({this.item});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return item == null
        ? Container()
        : Container(
           // height: 120.toHeight,
            padding: EdgeInsets.symmetric(
                vertical: 12.toHeight, horizontal: 8.toWidth),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.grey.withOpacity(0.3)))),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item.name ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4.toHeight,
                        ),
                        Text(
                          item.information ?? 'No description',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 16.toHeight,
                        ),
                        Container(
                          width: 130.toWidth,
                          height: 28.toHeight,
                          padding: EdgeInsets.symmetric(
                              vertical: 4.toHeight, horizontal: 8.toWidth),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                item.price ?? '',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Image.asset(
                                'assets/images/shop.png',
                                height: 18.toWidth,
                                width: 18.toWidth,
                                // fit: BoxFit.cover,
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: ThemeColor().greenLightColor,
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
                    child: FadeInImage(
                      image: NetworkImage(
                        item.image ??
                            'https://bees.az/___entcpanel/uploads/ef4534a27895456ef72f5acd7703ec9f_331778.png',
                      ),
                      height: 80.toHeight,
                      width: SizeConfig().screenWidth,
                      fit: BoxFit.cover,
                      placeholder: AssetImage(
                        'assets/images/no_image.png',
                      ),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          );
  }
}
