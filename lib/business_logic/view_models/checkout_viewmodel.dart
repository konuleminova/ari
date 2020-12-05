import 'package:ari/business_logic/models/checkout.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/hooks/useDioRequest.dart';
import 'package:ari/services/hooks/use_callback.dart';
import 'package:ari/services/services/map_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/views/checkout/checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CheckoutViewModel extends HookWidget {
RouteArguments<Checkout> checkout;
  @override
  Widget build(BuildContext context) {
    ApiResponse<List<LatLng>> apiResponse = useZoneService();
    checkout=ModalRoute.of(context).settings.arguments;
    return CustomErrorHandler(
      statuses: [apiResponse.status],
      errors: [apiResponse.error],
      child: CheckoutView(
          mapPoints: apiResponse.data,
          checkout:checkout.data,),
    );
  }
}
