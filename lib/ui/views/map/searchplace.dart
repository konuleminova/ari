import 'package:ari/ui/views/map/polygon_points/polygon_points.dart';
import 'package:ari/utils/map_utils/ui_id.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:ari/utils/size_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const kGoogleApiKey = "AIzaSyBESIdxnZrr-OvAY2-Ikes_rVuP-AXpKP8";
final searchScaffoldKey = GlobalKey<ScaffoldState>();
bool isOpen;
class CustomSearchScaffold extends PlacesAutocompleteWidget {
  final List<LatLng> points;

  CustomSearchScaffold(this.points)
      : super(
          apiKey: kGoogleApiKey,
          sessionToken: Uuid().generateV4(),
          language: "en",
          components: [Component(Component.country, "az")],
        );

  @override
  _CustomSearchScaffoldState createState() =>
      _CustomSearchScaffoldState(points);
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition;
  final List<LatLng> points;
  TextEditingController controller;
  String searchValue;

  _CustomSearchScaffoldState(this.points);

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
    isOpen=false;
    _lastMapPosition = const LatLng(40.3716222, 49.8555191);
    controller = new TextEditingController();
  }

  @override
  void didUpdateWidget(PlacesAutocompleteWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('SEARCH VALUE ${oldWidget.startText}');
    print('SEARCH VALUE ${searchValue}');
    if (oldWidget.startText == searchValue) {}
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
    print('RESPONSE ${response}');
  }

  _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onCameraMove(CameraPosition position) {}

  //Display Search Prediction and write address to SharedPreference
  Future<Null> displayPrediction(Prediction p, BuildContext context) async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;
//      if (p != null) {
//        SharedPrefUtil.putString(SharedPrefUtil.address, p.description);
//      }
//      SharedPrefUtil.putString(SharedPrefUtil.lat, lat.toString());
//      SharedPrefUtil.putString(SharedPrefUtil.lng, lng.toString());
      _lastMapPosition = new LatLng(lat, lng);
      _markers.clear();
      _markers.add(Marker(
          draggable: true,
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(title: p.description, snippet: ""),
          icon: BitmapDescriptor.defaultMarker));
      if (_mapController != null) {
        _mapController.animateCamera(CameraUpdate.newCameraPosition(
            new CameraPosition(target: _lastMapPosition, zoom: 12.00)));
      }
      setState(() {
        isOpen = false;
        //searchValue=p.description;
        //FocusScope.of(context).unfocus();
      });
    }
  }
}
