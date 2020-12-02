import 'package:ari/business_logic/models/checkout.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/ui/views/map/flutter_map.dart';
import 'package:ari/ui/views/map/searchplace.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ari/utils/size_config.dart';

class CheckoutView extends StatelessWidget {
  final List<LatLng> mapPoints;

  CheckoutView({this.mapPoints});

  RouteArguments<Checkout> checkout;

  @override
  Widget build(BuildContext context) {
    checkout = ModalRoute.of(context).settings.arguments;
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 70.toHeight),
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 8.toHeight,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 16.toWidth, vertical: 6.toHeight),
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(4)),
                          child: ListTile(
                            title: FutureBuilder(
                                future: _getAddress(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  return Text(
                                    snapshot.hasData && snapshot.data != ""
                                        ? snapshot.data
                                        : "Please add new address",
                                    style: TextStyle(fontSize: 13.toFont),
                                  );
                                }),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      Dialog(child: CustomSearchScaffold()));
                            },
                          ),
                        ),
                        Container(
                            height: SizeConfig().screenHeight / 2.4,
                            child: MapView(
                              points: mapPoints,
                            )),
                        Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: 16.toWidth),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    new Container(
                                        width: 40.toWidth,
                                        height: 40.toWidth,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: new NetworkImage(checkout
                                                    .data.restourant.image)))),
                                    SizedBox(
                                      width: 8.toWidth,
                                    ),
                                    Text(checkout
                                        .data.restourant.name??'',style: TextStyle(fontWeight: FontWeight.w500),)
                                  ],
                                ),
                                SizedBox(
                                  height: 16.toHeight,
                                ),
                                Container(
                                    // height: 260.toHeight,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: ThemeColor().grey1),
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: checkout.data.foodList.length,
                                        padding:
                                            EdgeInsets.only(top: 8.toHeight),
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                left: 8.toWidth),
                                            child: Text(
                                              '${index} ${ checkout.data.foodList[index].foods[0].name}',
                                              style: TextStyle(
                                                  fontSize: 12.toFont),
                                            ),
                                            height: 30.toHeight,
                                          );
                                        })),
                              ],
                            )),
                      ],
                    ))),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: ThemeColor().grey1),
                    color: ThemeColor().yellowColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                  height: 56.toHeight,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Go to payment',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 19.toFont),
                      ),
                      Text(
                        '${'23'} ₼',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 19.toFont),
                      )
                    ],
                  )),
            )
          ],
        ));
  }

  _getAddress() async {
    SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
    return await sharedPrefUtil.getString(SharedPrefUtil.address);
  }
}
