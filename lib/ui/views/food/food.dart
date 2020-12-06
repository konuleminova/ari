import 'package:ari/business_logic/models/checkout.dart';
import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/business_logic/view_models/menu_viewmodel.dart';
import 'package:ari/ui/views/food/widgets/food_item/food_item.dart';
import 'package:ari/ui/views/food/widgets/food_item/food_item_expanded.dart';
import 'package:ari/utils/sliver_delegate.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:ari/utils/size_config.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class FoodView extends StatelessWidget {
  List<GroupFood> foodList;
  var verticalScrollController;
  double maxExtentValue;
  var itemPositionsListener;
  Function(Food food) addtoCartCallback;
  Function(Food food) dropDownCallBack;
  var atLeastOneItemSelected;
  var addedFoodList;
  var goToPaymentCallBack;

  FoodView(
      {this.foodList,
      this.verticalScrollController,
      this.maxExtentValue,
      this.itemPositionsListener,
      this.addtoCartCallback,
      this.atLeastOneItemSelected,
      this.addedFoodList,
      this.goToPaymentCallBack,
      this.dropDownCallBack});

  RouteArguments<Restourant> arguments;

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;
    // TODO: implement build
    return foodList == null
        ? Container()
        : CustomScrollView(
            slivers: <Widget>[

              //Food Item Sliver AppBar
              SliverAppBar(
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(0),
                  child: SizedBox(),
                ),
                pinned: true,
                floating: true,
                snap: true,
                backgroundColor: Colors.transparent,
                expandedHeight: maxExtentValue < 0 ? 0 : 180.toHeight,
                flexibleSpace: AnimatedCrossFade(
                    crossFadeState: maxExtentValue < 0
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: Duration(milliseconds: 1400),
                    firstCurve: Curves.fastOutSlowIn,
                    secondCurve: Curves.fastOutSlowIn,
                    secondChild: SizedBox(),
                    firstChild: Stack(
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
                                  )
                                ],
                              ),
                              padding: EdgeInsets.all(8.toWidth),
                            )),
                      ],
                    )),
              ),

              //Menu Items Persistent Header
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                    child: PreferredSize(
                        preferredSize: Size.fromHeight(48.toHeight + 6),
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              child: MenuViewModel(
                                  foodList: foodList,
                                  id: arguments.data.id,
                                  verticalScrollController:
                                      verticalScrollController,
                                  itemPositionsListener: itemPositionsListener),
                              width: SizeConfig().screenWidth,
                              height: 48.toHeight,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.toWidth, vertical: 2),
                            ),
                            Container(color: ThemeColor().grey1, height: 2),
                          ],
                        ))),
              ),

              //Food Items List View
              SliverFillRemaining(
                  child: Stack(
                children: <Widget>[
                  ScrollablePositionedList.builder(
                    initialScrollIndex: 0,
                    itemScrollController: verticalScrollController,
                    physics: BouncingScrollPhysics(),
                    itemPositionsListener: itemPositionsListener,
                    padding:
                        EdgeInsets.only(top: 2.toHeight, bottom: 16.toHeight),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: 24.toWidth,
                                bottom: 4.toHeight,
                                top: 16.toHeight),
                            child: Text(
                              foodList[index].name,
                              style: TextStyle(
                                fontSize: 20.toFont,
                                color: ThemeColor().greenColor,
                              ),
                            ),
                          ),
                          ListView.builder(
                            itemBuilder:
                                (BuildContext context, int innerIndex) {
                              return AnimatedCrossFade(
                                duration: Duration(milliseconds: 400),
                                firstChild: FoodItem(
                                  addtoCartCallBack: addtoCartCallback,
                                  item: foodList[index].foods[innerIndex],
                                ),
                                secondChild: FoodItemExpanded(
                                  addtoCartCallBack: addtoCartCallback,
                                  food: foodList[index].foods[innerIndex],
                                  dropDownCallBack: dropDownCallBack,
                                ),
                                crossFadeState:
                                    foodList[index].foods[innerIndex].selected
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                              );
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
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: atLeastOneItemSelected
                        ? InkWell(
                            onTap: () {
                              goToPaymentCallBack();
                              pushRouteWithName(ROUTE_MAP,
                                  arguments: RouteArguments<Checkout>(
                                      data: Checkout(
                                          totalPrice: getTotalPrice(),
                                          foodList: addedFoodList,
                                          restourant: Restourant(
                                              image: arguments.data.image,
                                              name: arguments.data.name,
                                              id: arguments.data.id))));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: ThemeColor().grey1),
                                  color: ThemeColor().yellowColor,
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.toWidth),
                                height: 56.toHeight,
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Go to checkout',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 19.toFont),
                                    ),
                                    Text(
                                      '${getTotalPrice()} ₼',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 19.toFont),
                                    )
                                  ],
                                )))
                        : SizedBox(),
                  )
                ],
              ))
            ],
          );
  }

  String getTotalPrice() {
    double total = 0;
    foodList.forEach((element) {
      element.foods.forEach((element) {
        if (element.selected) {
          total = total + element.totalPrice;
        }
      });
    });
    return total.toStringAsFixed(2);
  }
}
