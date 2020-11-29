import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/business_logic/view_models/menu_viewmodel.dart';
import 'package:ari/ui/views/food/widgets/food_item.dart';
import 'package:ari/ui/views/food/widgets/sliver_delegate.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:ari/utils/size_config.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class FoodView extends StatelessWidget {
  List<GroupFood> foodList;
  var verticalScrollController;
  double maxExtentValue;
  var itemPositionsListener;

  FoodView(
      {this.foodList,
      this.verticalScrollController,
      this.maxExtentValue,
      this.itemPositionsListener});

  RouteArguments<Restourant> arguments;

  @override
  Widget build(BuildContext context) {
    print('FOOD VIEW ${maxExtentValue <4.0}');
    arguments = ModalRoute.of(context).settings.arguments;
    // TODO: implement build
    return foodList == null
        ? Container()
        : CustomScrollView(
            slivers: <Widget>[
              maxExtentValue <4.0
                  ? SliverPersistentHeader(
                      pinned: false,
                      delegate: SliverAppBarDelegate(
                          child: PreferredSize(
                              preferredSize: Size.fromHeight(180.toHeight),
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20.toFont,
                                                        shadows: <Shadow>[
                                                          Shadow(
                                                              offset: Offset(
                                                                  10.0, 10.0),
                                                              blurRadius: 30,
                                                              color:
                                                                  Colors.grey)
                                                        ]),
                                                  ),
                                                  SizedBox(
                                                    height: 4.toHeight,
                                                  ),
                                                  Text(
                                                    arguments.data.information,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.55),
                                                        fontSize: 14.toFont,
                                                        shadows: <Shadow>[
                                                          Shadow(
                                                              offset: Offset(
                                                                  10.0, 10.0),
                                                              blurRadius: 30,
                                                              color:
                                                                  Colors.grey)
                                                        ]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Icon(Icons.favorite_border,
                                                  size: 30,
                                                  color: Colors.white
                                                      .withOpacity(0.54)),
                                            )
                                          ],
                                        ),
                                        padding: EdgeInsets.all(8.toWidth),
                                      ))
                                ],
                              ))),
                    )
                  : SliverPersistentHeader(
                      pinned: false,
                      delegate: SliverAppBarDelegate(
                          child: PreferredSize(
                        preferredSize: Size.fromHeight(0),
                            child: SizedBox(),
                      ))),
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                    child: PreferredSize(
                        preferredSize: Size.fromHeight(44.toHeight),
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              child: MenuViewModel(
                                foodList: foodList,
                                id: arguments.data.id,
                                verticalScrollController:
                                    verticalScrollController,
                              ),
                              width: SizeConfig().screenWidth,
                              height: 40.toHeight,
                              padding:
                                  EdgeInsets.symmetric(horizontal: 8.toWidth),
                            ),
                            Container(color: ThemeColor().grey1, height: 2),
                          ],
                        ))),
              ),
              SliverFillRemaining(
                  child: ScrollablePositionedList.builder(
                    initialScrollIndex: 0,
                itemScrollController: verticalScrollController,
                physics: ClampingScrollPhysics(),
                itemPositionsListener: itemPositionsListener,
                padding: EdgeInsets.only(top: 8.toHeight),
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            left: 24.toWidth,
                            bottom: 16.toHeight,
                            top: 20.toHeight),
                        child: Text(
                          foodList[index].name,
                          style: TextStyle(
                            fontSize: 21.toFont,
                            color: ThemeColor().greenColor,
                          ),
                        ),
                      ),
                      ListView.builder(
                        itemBuilder: (BuildContext context, int innerIndex) {
                          return FoodItem(
                              item: foodList[index].foods[innerIndex]);
                        },
                        itemCount: foodList[index].foods.length,
                        padding: EdgeInsets.all(0),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      )
                    ],
                  );
                },
                itemCount: foodList.length ?? 0,
              ))
            ],
          );
  }
}

////              SliverAppBar(
////                backgroundColor: Colors.transparent,
////                expandedHeight: 180.toHeight,
////                pinned: false,
////                floating: false,
////                primary: true,
////                flexibleSpace: FlexibleSpaceBar(
////                    title: SizedBox(),
////                    background:
////                ),
////              ),
