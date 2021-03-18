import 'dart:async';

import 'package:ari/business_logic/models/status.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/services/status_service.dart';
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
  ValueNotifier<Order> order;
  ValueNotifier<ApiResponse<StatusModel>> apiResponseWithoutValue;
  ApiResponse<StatusModel> apiResponse;
  GoogleMapController _mapController;
  var _lastMapPosition2;
  var _lastMapPosition;
  Timer timer;

  @override
  Widget build(BuildContext context) {
    apiResponseWithoutValue = useState<ApiResponse<StatusModel>>();
    orderArguments = ModalRoute.of(context).settings.arguments;
    order = useState<Order>();
    if (order.value == null) {
      order.value = orderArguments.data;
    }

    var curyerCoordsKey = useState<UniqueKey>(new UniqueKey());
    ValueNotifier<Set<Marker>> markers = useState<Set<Marker>>(Set<Marker>());

    //get Curyer Coords
//    ApiResponse<String> curyerCoords =
//        useGetCuryerCoords(curyerCoordsKey.value, order.value.curyer?.id ?? '');
    apiResponseWithoutValue.value = useStatus(curyerCoordsKey.value);
    apiResponse = apiResponseWithoutValue.value;
    useEffect(() {
      timer = new Timer.periodic(Duration(seconds: 30), (timer) {
        curyerCoordsKey.value = new UniqueKey();
        if (apiResponse.status == Status.Done) {
          order.value = apiResponse.data.order[orderArguments.data.index];
          print(
              'COUNTDOWN MESSAGE ${apiResponse.data.order[orderArguments.data.index].countDownMessage}');
          print('ORDER DATA IS ${order.value.countDownMessage}');
          if (_mapController != null) {
            getBounWith(_mapController);
          }

          //order.value=null;
          order.notifyListeners();
        }
//        if (curyerCoords.status == Status.Done) {
//          if (curyerCoords.data != null) {
//            order.value.curyer?.coords = curyerCoords.data;
//            setCuryerCoords(markers);
//            markers.notifyListeners();
//          }
//        }
      });
      return () {
        timer.cancel();
      };
    }, [curyerCoordsKey.value, apiResponse.status]);

    //Restourant Coords
    if (order.value.restourant != null) {
      final position = order.value.restourant.coords;
      final split = position.trim().split(',');
      double lat = double.parse(split[0]);
      double lng = double.parse(split[1]);
      _lastMapPosition = LatLng(lat, lng);
      getBytesFromAsset('assets/images/restourant.png', 130).then((value) {
        final marker = Marker(
            draggable: true,
            markerId: MarkerId('111'),
            position: _lastMapPosition,
            infoWindow:
                InfoWindow(title: order.value.restourant.name, snippet: ""),
            icon: BitmapDescriptor.fromBytes(value));
        markers.value.add(marker);
        //markers.notifyListeners();
      });
    }

    //User coords
    if (order.value.coords != null) {
      final split2 = order.value.coords.trim().split(',');
      double lat2 = double.parse(split2[0]);
      double lng2 = double.parse(split2[1]);
      _lastMapPosition2 = LatLng(lat2, lng2);
      getBytesFromAsset('assets/images/user.png', 130).then((value) {
        final marker2 = Marker(
            draggable: true,
            markerId: MarkerId('112'),
            position: _lastMapPosition2,
            infoWindow: InfoWindow(title: order.value.address, snippet: ""),
            icon: BitmapDescriptor.fromBytes(value));
        markers.value.add(marker2);
        // markers.notifyListeners();
      });
    }

    //Curyer Coords
    if (order.value.curyer != null) {
      setCuryerCoords(markers);
    }
    //fit bounds

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
                          order.value.message ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16.toFont, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 4.toHeight,
                        ),
                        Text(
                          order.value.date,
                          style: TextStyle(
                              color: Colors.grey, fontSize: 12.toFont),
                        )
                      ],
                    ),
                  ),
                  order.value.hasCountdown == '1'
                      ? Container(
                          padding: EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  '${order.value.countDownMessage ?? ""}',
                                  style: TextStyle(fontSize: 13),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                width: SizeConfig().screenWidth / 1.7,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 24),
                                child: CountDownTimer(
                                  time: order.value.countDownMins,
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
                      //  height: 250.toHeight,
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
                                        '${order.value.foods[index].apiCount}. ${order.value.foods[index].name}             ${order.value.foods[index].count * double.parse(order.value.foods[index].price)} ₼ ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.toFont),
                                      ),
                                      Container(
                                        child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: order
                                                .value.foods[index].adds.length,
                                            itemBuilder:
                                                (BuildContext context, int i) {
                                              return Container(
                                                child: Text(
                                                  '${order.value.foods[index].adds[i].count}. ${order.value.foods[index].adds[i].name}',
                                                  style: TextStyle(
                                                      fontSize: 12.toFont),
                                                ),
                                                margin: EdgeInsets.only(
                                                    bottom: 4.toHeight,
                                                    left: 16.toWidth),
                                              );
                                            }),
                                      ),
                                    ],
                                  ));
                            },
                            itemCount: order.value.foods.length,
                          ))),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    height: 100,
                    child: Text(
                      order.value.totalpricemessage ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
                    margin: EdgeInsets.only(left: 24, right: 24),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ])),
            order.value.curyer != null
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
                                order.value.curyer.name ?? '',
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
                      onTap: () => UrlLauncher.launch(
                          "tel:+${order.value.curyer.mobile}"),
                    ))
                : SizedBox()
          ],
        ));
  }

  _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    getBounWith(_mapController);
  }

  void getBounWith(_mapController) {
    if (_lastMapPosition2 != null && _lastMapPosition != null) {
//      LatLngBounds bound = LatLngBounds(
//          southwest: _lastMapPosition2, northeast: _lastMapPosition);
      LatLngBounds bounds;
      LatLng source = _lastMapPosition;
      LatLng destination = _lastMapPosition2;
      if (source.latitude > destination.latitude &&
          source.longitude > destination.longitude) {
        bounds = LatLngBounds(southwest: destination, northeast: source);
      } else if (source.longitude > destination.longitude) {
        bounds = LatLngBounds(
            southwest: LatLng(source.latitude, destination.longitude),
            northeast: LatLng(destination.latitude, source.longitude));
      } else if (source.latitude > destination.latitude) {
        bounds = LatLngBounds(
            southwest: LatLng(destination.latitude, source.longitude),
            northeast: LatLng(source.latitude, destination.longitude));
      } else {
        bounds = LatLngBounds(southwest: source, northeast: destination);
      }
      CameraUpdate u2 = CameraUpdate.newLatLngBounds(bounds, 80);
      this._mapController.animateCamera(u2).then((void v) {
        check(u2, this._mapController);
      });
    }
  }

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    _mapController.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90)
      check(u, c);
  }

  void _onCameraMove(CameraPosition position) {}

  void setCuryerCoords(ValueNotifier<Set<Marker>> markers) {
    if (order.value.curyer.coords != null) {
      final split3 = order.value.curyer?.coords?.trim()?.split(',');
      double lat3 = double.parse(split3[0]);
      double lng3 = double.parse(split3[1]);
      final _lastMapPosition3 = LatLng(lat3, lng3);
      getBytesFromAsset('assets/images/curyer.png', 130).then((value) {
        final marker3 = Marker(
            draggable: true,
            markerId: MarkerId('113'),
            position: _lastMapPosition3,
            infoWindow: InfoWindow(title: order.value.curyer.name, snippet: ""),
            icon: BitmapDescriptor.fromBytes(value));
        if (markers.value.length > 3) {
          markers.value.removeWhere((element) => element.markerId == '113');
        }
        markers.value.add(marker3);
      });
    }
  }
}
