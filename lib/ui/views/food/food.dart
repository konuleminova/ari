import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/business_logic/view_models/menu_viewmodel.dart';
import 'package:ari/ui/views/food/widgets/food_item.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:ari/utils/size_config.dart';

class FoodView extends StatelessWidget {
  List<Food> foodList;
ScrollController scrollController = ScrollController();

  FoodView({this.foodList});

  RouteArguments<Restourant> arguments;

  @override
  Widget build(BuildContext context) {
    print('Foodlist: $foodList');
    arguments = ModalRoute.of(context).settings.arguments;
    // TODO: implement build
    return foodList == null
        ? Container()
        : NestedScrollView(
            physics: AlwaysScrollableScrollPhysics(),

            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  expandedHeight: 180.toHeight,
                  pinned: false,
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                      title: SizedBox(),
                      background: Stack(
                        children: <Widget>[
                          ClipRRect(
                            child: Image.network(
                              arguments.data.image,
                              width: SizeConfig().screenWidth,
                              height: SizeConfig().screenHeight,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
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
                                                      offset:
                                                          Offset(10.0, 10.0),
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
                                                      offset:
                                                          Offset(10.0, 10.0),
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
                                          color:
                                              Colors.white.withOpacity(0.54)),
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.all(8.toWidth),
                              ))
                        ],
                      )),
                )
              ];
            },
            body: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: MenuViewModel(
                      foodList: foodList,
                      id: arguments.data.id,
                      verticalScrollController: scrollController,
                    ),
                    width: SizeConfig().screenWidth,
                    height: 40.toHeight,
                    padding: EdgeInsets.symmetric(horizontal: 8.toWidth),
                  ),
                  Container(color: ThemeColor().grey1, height: 2),
                  Expanded(
                    flex: 3,
                    child: ListView.builder(
                     controller: scrollController,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return FoodItem(item: foodList[index]);
                      },
                      itemCount: foodList.length,
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
