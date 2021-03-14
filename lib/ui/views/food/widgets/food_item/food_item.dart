import 'package:ari/business_logic/models/food.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari/utils/size_config.dart';

class FoodItem extends StatelessWidget {
  Food item;
  Function(Food food) addtoCartCallBack;

  FoodItem({this.item, this.addtoCartCallBack});

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
                        Container(
                          child: Text(
                            item.information ?? 'No description',
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          height: item.information.isEmpty
                              ? 30.toHeight
                              : 70.toHeight,
                        ),
                        SizedBox(
                          height: 16.toHeight,
                        ),
                        InkWell(
                            child: Row(
                              children: [
                                Container(
                                  width: 130.toWidth,
                                  height: 28.toHeight,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.toHeight,
                                      horizontal: 8.toWidth),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        '${item.disCountPrice ?? item.price}   ₼' ??
                                            '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                SizedBox(
                                  width: 8,
                                ),
                                item.disCountPrice != null &&
                                        item.disCountPrice.isNotEmpty &&
                                        item.price != item.disCountPrice
                                    ? Text(
                                        item.price ?? '',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                            onTap: () {
                              item.selected = true;
                              // item.expanded = true;
                              addtoCartCallBack(item);
                            })
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
                    child: InkWell(
                      child: ClipRRect(
                        child: Image.network(
                          item.image,
                          height: 80.toHeight,
                          width: SizeConfig().screenWidth,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                                  child: Container(
                                    //height: 400.toHeight,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipRRect(
                                          child: Image.network(
                                            item.image,
                                            height: 200.toHeight,
                                            width: SizeConfig().screenWidth,
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        SizedBox(height: 16,),
                                       Container(child:  Text(
                                         item.information ?? 'No description',
                                         maxLines: 8,
                                         overflow: TextOverflow.ellipsis,
                                         style: TextStyle(
                                           color: Colors.white,
                                           fontSize: 20,
                                           fontWeight: FontWeight.bold,
                                         ),
                                       ),color: Colors.transparent,)
                                      ],
                                    ),
                                  ),
                                  backgroundColor: Colors.transparent,
                                ));
                      },
                    )),
              ],
            ),
          );
  }
}
