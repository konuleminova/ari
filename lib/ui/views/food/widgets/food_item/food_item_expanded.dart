import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/menu.dart';
import 'package:ari/ui/common_widgets/custom_dropdown.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter/material.dart';

class FoodItemExpanded extends StatelessWidget {
  final Food food;
  Function(Food food) addtoCartCallBack;
  Function(Food food) dropDownCallBack;
  FoodItemExpanded({this.food, this.addtoCartCallBack,this.dropDownCallBack});

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
                  padding: EdgeInsets.symmetric(horizontal: 4.toWidth),
                  decoration: BoxDecoration(
                      color: ThemeColor().yellowColor,
                      borderRadius: BorderRadius.circular(4)),
                  height: 34.toHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          if (food.count == 1) {
                            food.selected = false;
                          } else {
                            food.selected=true;
                            food.count = food.count - 1;
                            if(food.adds.length>0){
                              if (food.adds[1].type == 1 &&
                                  food.adds[1].count > food.count) {
                                food.adds[1].count = food.count;
                              }
                            }

                            print('CLICKED ${food.count}');
                          }
                          addtoCartCallBack(food);
                        },
                      ),
                      SizedBox(
                        width: 4.toWidth,
                      ),
                      Text((food.count).toString() ?? '0'),
                      SizedBox(
                        width: 4.toWidth,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          size: 18,
                        ),
                        onPressed: () {
                          food.count = food.count + 1;
                          addtoCartCallBack(food);
                        },
                      )
                    ],
                  )),
              Text(
                '${food.totalPrice.toStringAsFixed(2)}  ₼',
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
          ),
          SizedBox(
            height: 16.toHeight,
          ),
          ListView.builder(
            padding: EdgeInsets.all(0),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return food.adds[index].type != 2
                  ? Container(
                      margin: EdgeInsets.only(bottom: 8.toWidth),
                      width: SizeConfig().screenWidth,
                      // padding: EdgeInsets.symmetric(vertical: 8.toWidth),
                      decoration: BoxDecoration(
                          color: food.adds[index].type == 0
                              ? ThemeColor().yellowColor
                              : ThemeColor().grey1,
                          borderRadius: BorderRadius.circular(2)),
                      height: 44.toHeight,
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  food.adds[index].name.toString() ?? '',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                flex: 5,
                              ),
                              Expanded(
                                child: Text(
                                  ((food.adds[index].count == 0
                                                      ? 1
                                                      : (food
                                                          .adds[index].count)) *
                                                  double.tryParse(
                                                      food.adds[index].price))
                                              .toString() +
                                          '  ₼' ??
                                      '0',
                                  style: TextStyle(
                                      fontSize: 11.toFont,
                                      fontWeight: FontWeight.w500),
                                ),
                                flex: 2,
                              ),
                              SizedBox(
                                width: 4.toWidth,
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                    color: food.adds[index].type == 0
                                        ? ThemeColor().yellowColor
                                        : ThemeColor().greenLightColor,
                                    height: 44.toHeight,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.remove,
                                              size: 13,
                                            ),
                                            onPressed: () {
                                              if (food.adds[index].count > 0) {
                                                food.adds[index].count =
                                                    food.adds[index].count - 1;
                                                food.totalPrice =
                                                    food.totalPrice -
                                                        food.adds[index].count *
                                                            double.parse(food
                                                                .adds[index]
                                                                .price);
                                              }if(food.adds[index].count>0){
                                                food.adds[index].selected=true;
                                              }else{
                                                food.adds[index].selected=false;
                                              }
                                              addtoCartCallBack(food);
                                            },
                                          ),
                                        ),
                                        Text(
                                          food.adds[index].count.toString() ??
                                              '0',
                                          textAlign: TextAlign.center,
                                        ),
                                        Expanded(
                                          child: IconButton(
                                            icon: Icon(Icons.add, size: 13),
                                            onPressed: () {
                                              food.adds[index].count =
                                                  food.adds[index].count + 1;
                                              food.totalPrice =
                                                  food.totalPrice +
                                                      food.adds[index].count *
                                                          double.parse(food
                                                              .adds[index]
                                                              .price);
                                              if (food.adds[index].type == 1 &&
                                                  food.adds[index].count >
                                                      food.count) {
                                                food.count =
                                                    food.adds[index].count;
                                              }
                                              food.adds[index].selected=true;
                                              addtoCartCallBack(food);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4.toWidth,
                                        )
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                    )),
                              )
                            ],
                          ),
                          padding: EdgeInsets.only(left: 16.toWidth)))
                  : SizedBox();
            },
            itemCount: food.adds.length,
          ),
          food.addsType2.length > 0
              ? Container(
                  margin: EdgeInsets.only(bottom: 8.toWidth),
                  width: SizeConfig().screenWidth,
                  padding: EdgeInsets.only(
                      left: 16.toWidth, top: 4.toHeight, bottom: 4.toHeight),
                  decoration: BoxDecoration(
                      color: ThemeColor().yellowColor,
                      borderRadius: BorderRadius.circular(2)),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: CustomDropDown(
                          items: food.addsType2,
                          initialItemText: food.addsType2[0].name,
                          selectedFunction:(v){
                            food.addsType2[0].name=v;
                            dropDownCallBack(food);
                          },
                        ),
                        flex: 5,
                      ),
                      SizedBox(
                        width: 16.toWidth,
                      ),
                      Expanded(
                        child: Text(
                          '${((food.addsType2[0].count == 0 ? 1 : food.addsType2[0].count) * double.tryParse(food.addsType2[0].price)).toStringAsFixed(2)}  ₼',
                          style: TextStyle(
                              fontSize: 11.toFont, fontWeight: FontWeight.w500),
                        ),
                        flex: 2,
                      ),
                      SizedBox(
                        width: 4.toWidth,
                      ),
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: IconButton(
                                icon: Icon(
                                  Icons.remove,
                                  size: 13,
                                ),
                                onPressed: () {
                                  if (food.addsType2[0].count > 0) {
                                    food.addsType2[0].selected=true;
                                    food.addsType2[0].count =
                                        food.addsType2[0].count - 1;
                                    food.totalPrice = food.totalPrice -
                                        food.addsType2[0].count *
                                            double.parse(
                                                food.addsType2[0].price);
                                  }else{
                                    food.addsType2[0].selected=false;
                                  }

                                  addtoCartCallBack(food);
                                },
                              ),
                            ),
                            Text(
                              (food.addsType2[0].count).toString() ?? '0',
                              textAlign: TextAlign.center,
                            ),
                            Expanded(
                              child: IconButton(
                                icon: Icon(Icons.add, size: 13),
                                onPressed: () {
                                  food.addsType2[0].count =
                                      food.addsType2[0].count + 1;
                                  food.totalPrice = food.totalPrice +
                                      food.addsType2[0].count *
                                          double.parse(food.addsType2[0].price);
                                  food.addsType2[0].selected=true;
                                  addtoCartCallBack(food);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 4.toWidth,
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      )
                    ],
                  ))
              : SizedBox()
        ],
      ),
    );
  }
}
