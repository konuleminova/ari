import 'package:ari/ui/views/map/polygon_points/polygon_points.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final List<LatLng> points;

  const MapView({Key key, this.points}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MapViewState();
  }
}

class _MapViewState extends State<MapView> {
  GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition;

  @override
  void dispose() {
    super.dispose();
    _mapController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _lastMapPosition = const LatLng(40.3716222, 49.8555191);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: EdgeInsets.all(1),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.35,
      alignment: AlignmentDirectional.topCenter,
      color: Colors.white,
      child: FutureBuilder(
          future: _setSelectedAddress(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return GoogleMap(
              gestureRecognizers: Set()
                ..add(
                    Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                ..add(Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer())),
              onTap: (LatLng location) {
                //MapDemoPage mp = new MapDemoPage();
                // mp.showMap();
              },
              polygons: setPolygon(widget.points),
              tiltGesturesEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              markers: _markers,
              onCameraMove: _onCameraMove,
              onMapCreated: _onMapCreated,
              initialCameraPosition:
                  CameraPosition(target: _lastMapPosition, zoom: 11.00),
            );
          }),
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 5),
    );
  }

  _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  //Set search result address and animate camera to there
  _setSelectedAddress() async {
    SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
    String address = await sharedPrefUtil.getString(SharedPrefUtil.address);
    _lastMapPosition = new LatLng(
        double.parse(await sharedPrefUtil.getString(SharedPrefUtil.lat)),
        double.parse(await sharedPrefUtil.getString(SharedPrefUtil.lng)));
    _markers.clear();
    _markers.add(Marker(
        draggable: true,
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(title: address, snippet: ""),
        icon: BitmapDescriptor.defaultMarker));
    if (_mapController != null) {
      _mapController.animateCamera(CameraUpdate.newCameraPosition(
          new CameraPosition(target: _lastMapPosition, zoom: 12.00)));
    }
    return address;
  }

  void _onCameraMove(CameraPosition position) {}
}
