import 'dart:io';

import 'package:ari/business_logic/models/checkout.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/hooks/useDioRequest.dart';
import 'package:ari/services/hooks/use_callback.dart';
import 'package:ari/services/provider/provider.dart';
import 'package:ari/services/services/map_service.dart';
import 'package:ari/services/services/payment_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/provider/checkout/checkout_action.dart';
import 'package:ari/ui/provider/checkout/checkout_state.dart';
import 'package:ari/ui/provider_components/counter_state.dart';
import 'package:ari/ui/views/checkout/checkout.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';

class CheckoutViewModel extends HookWidget {
  RouteArguments<Checkout> checkout;

  @override
  Widget build(BuildContext context) {
    ApiResponse<List<LatLng>> apiResponse = useZoneService();
    checkout = ModalRoute.of(context).settings.arguments;
    final store = useCheckoutStore();
    useProviderRegistration(store);
    //get curyer price

    final apiResponse2 = useGetCuryerPrice(checkout.data.restourant.id);
    useEffect(() {
      if (apiResponse2.status == Status.Done) {
        double total = double.parse(checkout.data.totalPrice);
        double delivery = double.parse(apiResponse2.data);
        total = total + delivery;
        checkout.data.totalPrice = total.toStringAsFixed(2);
      }
      return () {};
    }, [apiResponse2]);

    useEffect(() {
      apiResponse2.status=Status.Loading;
      if (Platform.isAndroid) {
        Geolocator.checkPermission().then((value) {
          Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
              .then((value) {
            SpUtil.putString(SpUtil.lat, value.latitude.toString());
            SpUtil.putString(SpUtil.lng, value.longitude.toString());
            Geocoder.local
                .findAddressesFromCoordinates(
                    Coordinates(value.latitude, value.longitude))
                .then((valuex) {
              SpUtil.putString(SpUtil.address, valuex.first.addressLine ?? '');
              print("MY ADDRESS ${valuex.first.addressLine}");
              apiResponse2.status=Status.Done;
            });
          });
        });
      }
      return () {};
    }, []);

    return CustomErrorHandler(
      statuses: [apiResponse.status],
      errors: [apiResponse.error],
      child: Provider<Store<CheckoutState, CheckoutAction>>(
        value: store,
        child: CheckoutView(
          mapPoints: apiResponse.data,
          checkout: checkout.data,
          store: store,
          deliveryPrice: apiResponse2.data,
        ),
      ),
    );
  }
}
