import 'package:ari/utils/map_utils/ui_id.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';

const kGoogleApiKey = "AIzaSyBESIdxnZrr-OvAY2-Ikes_rVuP-AXpKP8";
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold()
      : super(
          apiKey: kGoogleApiKey,
          sessionToken: Uuid().generateV4(),
          language: "en",
          components: [Component(Component.country, "az")],
        );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: AppBarPlacesAutoCompleteTextField(),
      backgroundColor: ThemeColor().greenLightColor,
      leading: IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    final body = PlacesAutocompleteResult(
      onTap: (p) {
        displayPrediction(p, searchScaffoldKey.currentState, context);
        //print(p.description);
      },
      logo: Row(
        children: [Container()],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
    return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    searchScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);
//    if (response != null && response.predictions.isNotEmpty) {
//      searchScaffoldKey.currentState.showSnackBar(
//        SnackBar(content: Text("Got answer")),
//      );
//    }
  }

//Display Search Prediction and write address to SharedPreference
  Future<Null> displayPrediction(
      Prediction p, ScaffoldState scaffold, BuildContext context) async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;
      SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
      if (p != null) {
        await sharedPrefUtil.setString(SharedPrefUtil.address, p.description);
      }
      await sharedPrefUtil.setString(SharedPrefUtil.lat, lat.toString());
      await sharedPrefUtil.setString(SharedPrefUtil.lng, lng.toString());
      Navigator.pop(context);
    }
  }
}
