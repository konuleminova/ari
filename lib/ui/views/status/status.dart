import 'package:ari/business_logic/models/status.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/utils/size_config.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StatusView extends StatelessWidget {
  RouteArguments<Order> orderArguments;
  Order order;

  GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    orderArguments = ModalRoute.of(context).settings.arguments;
    order = orderArguments.data;
    final position =order.restourant.coords;
    final split=position.trim().split(',');
   double lat =double.parse(split[0]);
   double lng=double.parse(split[1]);
    final _lastMapPosition =  LatLng(lat, lng);

    final split2=order.coords.trim().split(',');
    double lat2 =double.parse(split2[0]);
    double lng2=double.parse(split2[1]);
    final _lastMapPosition2 =  LatLng(lat2, lng2);
    // TODO: implement build
    return Container(
        height: SizeConfig().screenHeight,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              Container(
                //color: ThemeColor().grey1,
                width: SizeConfig().screenWidth,
                height: 55.toHeight,
                margin: EdgeInsets.all(24.toWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      order.message,
                      style: TextStyle(
                          fontSize: 16.toFont, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 4.toHeight,
                    ),
                    Text(
                      order.date,
                      style: TextStyle(color: Colors.grey, fontSize: 12.toFont),
                    )
                  ],
                ),
              ),
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
                   markers: Set<Marker>()..add(Marker(
                       draggable: true,
                       markerId: MarkerId(_lastMapPosition.toString()),
                       position: _lastMapPosition,
                       infoWindow: InfoWindow(title: order.restourant.name, snippet: ""),
                       icon: BitmapDescriptor.defaultMarker))..add(Marker(
                       draggable: true,
                       markerId: MarkerId(_lastMapPosition2.toString()),
                       position: _lastMapPosition2,
                       infoWindow: InfoWindow(title: order.address, snippet: ""),
                       icon: BitmapDescriptor.defaultMarker)),
                  onCameraMove: _onCameraMove,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition:
                      CameraPosition(target: _lastMapPosition, zoom: 11.00),
                ),
              ),
              Container(
                  height: 250.toHeight,
                  width: SizeConfig().screenWidth,
                  child: Container(
                      padding: EdgeInsets.all(16.toWidth),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              margin: EdgeInsets.only(bottom: 4.toHeight),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    '${order.foods[index].count}  ${order.foods[index].name}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.toFont),
                                  ),
                                  Container(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            order.foods[index].adds.length,
                                        itemBuilder:
                                            (BuildContext context, int i) {
                                          return Container(
                                            child: Text(
                                              '${order.foods[index].adds[i].count} ${order.foods[index].adds[i].name}',
                                              style: TextStyle(
                                                  fontSize: 13.toFont),
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
            ])));
  }

  _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

  }

  void _onCameraMove(CameraPosition position) {}
}