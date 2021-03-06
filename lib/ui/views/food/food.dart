import 'package:ari/business_logic/models/checkout.dart';
import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/business_logic/view_models/menu_viewmodel.dart';
import 'package:ari/localization/app_localization.dart';
import 'package:ari/ui/views/food/widgets/food_item/animation_bee.dart';
import 'package:ari/utils/map_utils/check_loaction_permission.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:ari/utils/sliver_delegate.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:ari/utils/size_config.dart';
import 'package:geolocator/geolocator.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class FoodView extends StatelessWidget {
  var verticalScrollController;
  double maxExtentValue;
  var itemPositionsListener;
  Function(Food food) addtoCartCallback;
  Function(Food food) dropDownCallBack;
  var atLeastOneItemSelected;
  var addedFoodList;
  var goToPaymentCallBack;
  List<Food> foods;
  bool hasSticker = false;

  FoodView({
    this.verticalScrollController,
    this.maxExtentValue,
    this.itemPositionsListener,
    this.addtoCartCallback,
    this.atLeastOneItemSelected,
    this.addedFoodList,
    this.goToPaymentCallBack,
    this.dropDownCallBack,
    this.foods,
  });

  RouteArguments<Restourant> arguments;

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context).settings.arguments;
    hasSticker = arguments.data.sticker_st_color != null &&
        arguments.data.sticker_st_color.isNotEmpty &&
        arguments.data.sticker_en_color != null &&
        arguments.data.sticker_en_color.isNotEmpty;
    // TODO: implement build
    return CustomScrollView(
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
          expandedHeight: maxExtentValue < 0
              ? 0
              : hasSticker
                  ? 234.toHeight
                  : 180.toHeight,
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
                  Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          child: Image.network(
                            arguments.data.image ?? '',
                            width: SizeConfig().screenWidth,
                            height: SizeConfig().screenHeight,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                        ),
                      ),
                      hasSticker
                          ? Container(
                              height: 44.toHeight,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(int.parse(
                                        '0xFF${arguments.data.sticker_st_color.substring(1)}')),
                                    Color(int.parse(
                                        '0xFF${arguments.data.sticker_en_color.substring(1)}')),
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  arguments.data.sticker_text ?? '',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          : SizedBox()
                    ],
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  Positioned(
                      bottom: hasSticker ? 44.toHeight : 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    arguments.data.name ?? '',
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
                                    arguments.data.sm_name ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
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
//                            Container(
//                              child: Icon(Icons.favorite_border,
//                                  size: 30,
//                                  color: Colors.white.withOpacity(0.54)),
//                            )
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
                            foodList: foods,
                            id: arguments.data.id ?? '',
                            verticalScrollController: verticalScrollController,
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
              padding: EdgeInsets.only(
                  top: 2.toHeight,
                  bottom: atLeastOneItemSelected ? 56.toHeight : 16.toHeight),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    foods[index].groupName != null
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: 24.toWidth,
                                bottom: 4.toHeight,
                                top: 16.toHeight),
                            child: Text(
                              foods[index].groupName,
                              style: TextStyle(
                                fontSize: 20.toFont,
                                color: ThemeColor().greenColor,
                              ),
                            ),
                          )
                        : SizedBox(),
                    AnimationBee(
                      food: foods[index],
                      addtoCartCallback: addtoCartCallback,
                      dropDownCallBack: dropDownCallBack,
                      working: arguments.data.working,
                    )
                  ],
                );
              },
              itemCount: foods.length ?? 0,
            ),

            //Go to checkout View
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: atLeastOneItemSelected
                  ? InkWell(
                      onTap: () {
                        if (arguments.data.working) {
                          goToPaymentCallBack();
                          if (SpUtil.getString(SpUtil.token).isNotEmpty) {
                            checkPermissionLocation(
                                context: context,
                                onSuccess: () {
                                  pushRouteWithName(ROUTE_MAP,
                                      arguments: RouteArguments<Checkout>(
                                          data: Checkout(
                                              totalPrice: getTotalPrice(),
                                              foodList: addedFoodList,
                                              isFroMap: true,
                                              restourant: Restourant(
                                                  image: arguments.data.image,
                                                  name: arguments.data.name,
                                                  id: arguments.data.id,
                                                  percent: arguments
                                                      .data.percent))));
                                });
                          } else {
                            pushRouteWithName(ROUTE_LOGIN,
                                arguments: RouteArguments<Checkout>(
                                    data: Checkout(
                                        totalPrice: getTotalPrice(),
                                        foodList: addedFoodList,
                                        isFroMap: true,
                                        restourant: Restourant(
                                            image: arguments.data.image,
                                            name: arguments.data.name,
                                            id: arguments.data.id,
                                            percent: arguments.data.percent))));
                          }
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: ThemeColor().grey1),
                            color: arguments.data.working
                                ? ThemeColor().yellowColor
                                : Colors.red,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                          height: 56.toHeight,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context).translate(
                                        arguments.data.working
                                            ? 'Go to checkout'
                                            : "rest_not_working") ??
                                    'Go to checkout',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 19.toFont),
                              ),
                              arguments.data.working
                                  ? Text(
                                      '${getTotalPrice()} ???',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 19.toFont),
                                    )
                                  : SizedBox()
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
    foods.forEach((element) {
      if (element.selected) {
        total = total + element.totalPrice;
      }
    });
    return total.toStringAsFixed(2);
  }
}
