import 'package:ari/business_logic/models/status.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/ui/views/status/widgets/countdown_timer.dart';
import 'package:ari/utils/map_utils/marker_icon.dart';
import 'package:ari/utils/size_config.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class StatusView extends HookWidget {
  RouteArguments<Order> orderArguments;
  Order order;

  GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    orderArguments = ModalRoute.of(context).settings.arguments;
    order = orderArguments.data;

    ValueNotifier<Set<Marker>> markers = useState<Set<Marker>>(Set<Marker>());
    var _lastMapPosition2;

    //Restourant Coords
    if (order.restourant != null) {
      final position = order.restourant.coords;
      final split = position.trim().split(',');
      double lat = double.parse(split[0]);
      double lng = double.parse(split[1]);
      final _lastMapPosition = LatLng(lat, lng);
      getBytesFromAsset('assets/images/restourant.png', 130).then((value) {
        final marker = Marker(
            draggable: true,
            markerId: MarkerId(_lastMapPosition.toString()),
            position: _lastMapPosition,
            infoWindow: InfoWindow(title: order.restourant.name, snippet: ""),
            icon: BitmapDescriptor.fromBytes(value));
        markers.value.add(marker);
        //markers.notifyListeners();
      });
    }

    //User coords
    if (order.coords != null) {
      final split2 = order.coords.trim().split(',');
      double lat2 = double.parse(split2[0]);
      double lng2 = double.parse(split2[1]);
      _lastMapPosition2 = LatLng(lat2, lng2);
      getBytesFromAsset('assets/images/user.png', 130).then((value) {
        final marker2 = Marker(
            draggable: true,
            markerId: MarkerId(_lastMapPosition2.toString()),
            position: _lastMapPosition2,
            infoWindow: InfoWindow(title: order.address, snippet: ""),
            icon: BitmapDescriptor.fromBytes(value));
        markers.value.add(marker2);
        // markers.notifyListeners();
      });
    }

    //Curyer Coords
    if (order.curyer != null) {
      final split3 = order.curyer?.coords?.trim()?.split(',');
      double lat3 = double.parse(split3[0]);
      double lng3 = double.parse(split3[1]);
      final _lastMapPosition3 = LatLng(lat3, lng3);
      getBytesFromAsset('assets/images/curyer.png', 130).then((value) {
        final marker3 = Marker(
            draggable: true,
            markerId: MarkerId(_lastMapPosition3.toString()),
            position: _lastMapPosition3,
            infoWindow: InfoWindow(title: order.curyer.name, snippet: ""),
            icon: BitmapDescriptor.fromBytes(value));
        markers.value.add(marker3);
        //markers.notifyListeners();
      });
    }

    // TODO: implement build
    return Container(
        height: SizeConfig().screenHeight,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                  Container(
                    color: ThemeColor().grey1.withOpacity(0.4),
                    width: SizeConfig().screenWidth,
                    height: 80.toHeight,
                    padding: EdgeInsets.all(24.toWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          order.message ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16.toFont, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 4.toHeight,
                        ),
                        Text(
                          order.date,
                          style: TextStyle(
                              color: Colors.grey, fontSize: 12.toFont),
                        )
                      ],
                    ),
                  ),
                  order.hasCountdown == '1'
                      ? Container(
                          padding: EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  '${order.countDownMessage ?? ""}',
                                  style: TextStyle(fontSize: 13),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                width: SizeConfig().screenWidth/1.7,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 24),
                                child: CountDownTimer(
                                  time: order.countDownMins,
                                ),
                              ),
                            ],
                          ),
                          color: ThemeColor().yellowColor,
                          height: 74.toHeight,
                          width: SizeConfig().screenWidth,
                        )
                      : SizedBox(),
                  Container(
                    height: 300.toHeight,
                    child: GoogleMap(
                      gestureRecognizers: Set()
                        ..add(Factory<PanGestureRecognizer>(
                            () => PanGestureRecognizer()))
                        ..add(Factory<VerticalDragGestureRecognizer>(
                            () => VerticalDragGestureRecognizer())),
                      onTap: (LatLng location) {
                        //MapDemoPage mp = new MapDemoPage();
                        // mp.showMap();
                      },
                      tiltGesturesEnabled: true,
                      scrollGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      markers: markers.value,
                      onCameraMove: _onCameraMove,
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                          target: _lastMapPosition2 ??
                              const LatLng(40.3716222, 49.8555191),
                          zoom: 11.00),
                    ),
                  ),
                  Container(
                      height: 250.toHeight,
                      width: SizeConfig().screenWidth,
                      child: Container(
                          padding: EdgeInsets.all(24.toWidth),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  margin: EdgeInsets.only(bottom: 4.toHeight),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${order.foods[index].apiCount}. ${order.foods[index].name}             ${order.foods[index].count * double.parse(order.foods[index].price)} ₼ ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.toFont),
                                      ),
                                      Container(
                                        child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                order.foods[index].adds.length,
                                            itemBuilder:
                                                (BuildContext context, int i) {
                                              return Container(
                                                child: Text(
                                                  '${order.foods[index].adds[i].count}. ${order.foods[index].adds[i].name}',
                                                  style: TextStyle(
                                                      fontSize: 12.toFont),
                                                ),
                                                margin: EdgeInsets.only(
                                                    bottom: 4.toHeight,
                                                    left: 16.toWidth),
                                              );
                                            }),
                                      )
                                    ],
                                  ));
                            },
                            itemCount: order.foods.length,
                          )))
                ])),
            order.curyer != null
                ? Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: InkWell(
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: ThemeColor().grey1),
                              color: ThemeColor().yellowColor),
                          padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                          height: 56.toHeight,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                order.curyer.name ?? '',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.toFont),
                              ),
                              Image.asset(
                                'assets/images/call.png',
                                width: 30,
                                height: 30,
                              )
                            ],
                          )),
                      onTap: () =>
                          UrlLauncher.launch("tel://${order.curyer.mobile}"),
                    ))
                : SizedBox()
          ],
        ));
  }

  _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {}
}
