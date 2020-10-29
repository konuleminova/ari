import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/business_logic/view_models/menu_viewmodel.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/ui/common_widgets/loading.dart';
import 'package:ari/ui/views/food/widgets/food_item.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari/utils/size_config.dart';

class FoodView extends StatelessWidget {
  List<Food> foodList;

  FoodView({this.foodList});

  RouteArguments<Restourant> arguments;

  @override
  Widget build(BuildContext context) {
    print('Foodlist: $foodList');
    arguments = ModalRoute.of(context).settings.arguments;
    // TODO: implement build
    return foodList == null
        ? Container()
        : Container(
            child: Column(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          child: Image.network(
                            arguments.data.image,
                            width: SizeConfig().screenWidth,
                            height: SizeConfig().screenHeight,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(20)),
                        ),
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          arguments.data.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.toFont,
                                              shadows: <Shadow>[
                                                Shadow(
                                                    offset: Offset(10.0, 10.0),
                                                    blurRadius: 30,
                                                    color: Colors.grey)
                                              ]),
                                        ),
                                        SizedBox(
                                          height: 4.toHeight,
                                        ),
                                        Text(
                                          arguments.data.information,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.55),
                                              fontSize: 14.toFont,
                                              shadows: <Shadow>[
                                                Shadow(
                                                    offset: Offset(10.0, 10.0),
                                                    blurRadius: 30,
                                                    color: Colors.grey)
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Icon(Icons.favorite_border,
                                        size: 30,
                                        color: Colors.white.withOpacity(0.54)),
//                                    decoration: BoxDecoration(
//                                        boxShadow: <BoxShadow>[
//                                          BoxShadow(blurRadius: 30,color: Colors.grey,   offset: Offset(10.0, 10.0),)
//                                        ]),
                                  )
                                ],
                              ),
                              padding: EdgeInsets.all(8.toWidth),
                            ))
                      ],
                    )),
                Container(
                    child: MenuViewModel(
                      id: arguments.data.id,
                    ),
                    width: SizeConfig().screenWidth,
                    height: 34.toHeight),
                Container(color: ThemeColor().grey1, height: 2),
                Expanded(
                  flex: 3,
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return FoodItem(item: foodList[index]);
                    },
                    itemCount: foodList.length,
                  ),
                )
              ],
            ),
          );
  }
}
