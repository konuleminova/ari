import 'package:ari/ui/provider/checkout/checkout_action.dart';
import 'package:ari/ui/views/map/polygon_points/polygon_points.dart';
import 'package:ari/utils/map_utils/flutter_google_places.dart';
import 'package:ari/utils/map_utils/point_inpolygon.dart';
import 'package:ari/utils/map_utils/ui_id.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter/material.dart';
import 'package:ari/utils/size_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const kGoogleApiKey = "AIzaSyBESIdxnZrr-OvAY2-Ikes_rVuP-AXpKP8";
final searchScaffoldKey = GlobalKey<ScaffoldState>();
bool isOpen;

class CustomSearchScaffold extends PlacesAutocompleteWidget {
  final List<LatLng> points;
  var store;

  CustomSearchScaffold(this.points, this.store)
      : super(
          apiKey: kGoogleApiKey,
          sessionToken: Uuid().generateV4(),
          language: "en",
          startText: SpUtil.getString(SpUtil.address).isNotEmpty
              ? SpUtil.getString(SpUtil.address)
              : 'Please add new Address',
          components: [Component(Component.country, "az")],
        );

  @override
  _CustomSearchScaffoldState createState() =>
      _CustomSearchScaffoldState(points, store);
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition;
  final List<LatLng> points;
  TextEditingController controller;
  String searchValue;
  var store;

  _CustomSearchScaffoldState(this.points, this.store);

  @override
  Widget build(BuildContext context) {
    final bodyMap = Container(
      padding: EdgeInsets.all(1),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.35,
      alignment: AlignmentDirectional.topCenter,
      color: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GoogleMap(
          gestureRecognizers: Set()
            ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
            ..add(Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer())),
          onTap: (LatLng location) {
            //MapDemoPage mp = new MapDemoPage();
            // mp.showMap();
          },
          polygons: setPolygon(points),
          tiltGesturesEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          markers: _markers,
          onCameraMove: _onCameraMove,
          onMapCreated: _onMapCreated,
          initialCameraPosition:
              CameraPosition(target: _lastMapPosition, zoom: 11.00),
        ),
      ),
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 5),
    );
    final body = PlacesAutocompleteResult(
      onTap: (p) {
        displayPrediction(p, context);
        //print(p.description);
      },
      logo: SizedBox(),
    );
    return Container(
      height: 300.toHeight,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              child: bodyMap,
              margin: EdgeInsets.only(top: 54.toHeight),
            ),
            top: 0,
            left: 0,
            right: 0,
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 16.toWidth, vertical: 6.toHeight),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4)),
                child: AppBarPlacesAutoCompleteTextField(),
              ),
              isOpen
                  ? Card(
                      child: Container(
                      child: body,
                      height: 220.toHeight,
                    ))
                  : SizedBox()
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    isOpen = false;
    _lastMapPosition = const LatLng(40.3716222, 49.8555191);
    controller = new TextEditingController();
    if (SpUtil.getString(SpUtil.address).isNotEmpty) {
      displayPrediction(null, context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _mapController.dispose();
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    searchScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  @override
  Future<Null> doSearch(String value) {
    super.doSearch(value);
    if (value != searchValue) {
      if (value.isNotEmpty) {
        isOpen = true;
        searchValue = value;
        setState(() {});
      } else {
        isOpen = false;
      }
    }
  }

  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);
    if (response != null) {
      if (response.hasNoResults) {
        setState(() {
          isOpen = false;
        });
      }
    } else {
      setState(() {
        isOpen = false;
      });
    }
  }

  _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {}

  //Display Search Prediction and write address to SharedPreference
  Future<Null> displayPrediction(Prediction p, BuildContext context) async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
    PlacesDetailsResponse detail;
    var lat;
    var lng;
    var placeId;
    var description;
    if (p == null) {
      detail =
          await _places.getDetailsByPlaceId(SpUtil.getString(SpUtil.placeId));
      lat = double.parse(SpUtil.getString(SpUtil.lat));
      lng = double.parse(SpUtil.getString(SpUtil.lng));
      placeId = SpUtil.getString(SpUtil.placeId);
      description = SpUtil.getString(SpUtil.address);
    }
    // get detail (lat/lng)
    else {
      detail = await _places.getDetailsByPlaceId(p.placeId);
      lat = detail.result.geometry.location.lat;
      lng = detail.result.geometry.location.lng;
      placeId = p.placeId;
      description = p.description;
    }
    await SpUtil.putString(SpUtil.address, description);
    await SpUtil.putString(SpUtil.lat, lat.toString());
    await SpUtil.putString(SpUtil.lng, lng.toString());
    await SpUtil.putString(SpUtil.placeId, placeId);
    _lastMapPosition = new LatLng(lat, lng);
    _markers.clear();
    _markers.add(Marker(
        draggable: true,
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(title: description, snippet: ""),
        icon: BitmapDescriptor.defaultMarker));
    if (_mapController != null) {
      _mapController.animateCamera(CameraUpdate.newCameraPosition(
          new CameraPosition(target: _lastMapPosition, zoom: 12.00)));
    }
    if (isPointInPolygon(LatLng(lat, lng), points)) {
      print('It is in polygon');
      if (store != null) {
        store
            .dispatch(CheckoutAction(description ?? '', '${lat},${lng}', true));
      }
      await SpUtil.putBool(SpUtil.isPointInPolygon, true);
    } else {
      store.dispatch(CheckoutAction('', '', false));
      print('It is not in polygon');
      Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Seçdiyiniz əraziyə çcatdırılma mövcud deyil.')));
      await SpUtil.putBool(SpUtil.isPointInPolygon, false);
    }

    setState(() {
      isOpen = false;
      FocusScope.of(context).unfocus();
    });
  }
}
