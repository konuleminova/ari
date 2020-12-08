import 'package:ari/business_logic/models/status.dart';
import 'package:ari/utils/size_config.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StatusView extends StatelessWidget {
  Order order;

  StatusView({this.order});

  GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    final _lastMapPosition = const LatLng(40.3716222, 49.8555191);
    // TODO: implement build
    return Container(
        height: SizeConfig().screenHeight,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
            child: Column(children: [
          Container(
            color: ThemeColor().grey1,
            margin: EdgeInsets.all(24.toWidth),
            child: Column(
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
            height: 200.toHeight,
            child: GoogleMap(
              gestureRecognizers: Set()
                ..add(
                    Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                ..add(Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer())),
              onTap: (LatLng location) {
                //MapDemoPage mp = new MapDemoPage();
                // mp.showMap();
              },
              tiltGesturesEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              // markers: _markers,
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
                  color: Colors.white,
                  padding: EdgeInsets.all(16.toWidth),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: ThemeColor().grey1),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: EdgeInsets.only(bottom: 4.toHeight),
                          child: Column(
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
                                    itemCount: order.foods[index].adds.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return Container(
                                        child: Text(
                                          '${order.foods[index].adds[i].count} ${order.foods[index].adds[i].name}',
                                          style: TextStyle(fontSize: 13.toFont),
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
