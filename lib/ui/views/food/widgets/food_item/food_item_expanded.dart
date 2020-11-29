import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/menu.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter/material.dart';

class FoodItemExpanded extends StatelessWidget {
  final Food food;

  FoodItemExpanded({this.food});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 8.toHeight),
      padding:
          EdgeInsets.symmetric(horizontal: 30.toWidth, vertical: 16.toWidth),
      decoration: BoxDecoration(
        color: ThemeColor().yellowColor.withOpacity(0.3),
        border: Border(
            top: BorderSide(color: ThemeColor().yellowColor),
            bottom: BorderSide(color: ThemeColor().yellowColor)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            child: FadeInImage(
              image: NetworkImage(
                food.image ??
                    'https://bees.az/___entcpanel/uploads/ef4534a27895456ef72f5acd7703ec9f_331778.png',
              ),
              height: 150.toHeight,
              width: SizeConfig().screenWidth,
              fit: BoxFit.cover,
              placeholder: AssetImage(
                'assets/images/no_image.png',
              ),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          SizedBox(
            height: 12.toHeight,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  //   width: 120.toWidth,
                  padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                  decoration: BoxDecoration(
                      color: ThemeColor().yellowColor,
                      borderRadius: BorderRadius.circular(4)),
                  height: 34.toHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.remove,
                        size: 18,
                      ),
                      SizedBox(
                        width: 8.toWidth,
                      ),
                      Text(food.price ?? ''),
                      SizedBox(
                        width: 8.toWidth,
                      ),
                      Icon(
                        Icons.add,
                        size: 18,
                      ),
                    ],
                  )),
              Text(
                food.price,
                style:
                    TextStyle(fontSize: 20.toFont, fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            height: 16.toHeight,
          ),
          Text(
            food.name ?? '',
            style: TextStyle(fontSize: 16.toFont, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 2.toHeight,
          ),
          Text(
            food.information ?? 'No description',
            style: TextStyle(color: ThemeColor().greyColor),
          )
        ],
      ),
    );
  }
}
