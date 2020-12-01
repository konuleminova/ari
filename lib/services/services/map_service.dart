import 'package:ari/business_logic/models/food.dart';
import 'package:ari/services/api_helper/api_config.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/api_helper/dio_config.dart';
import 'package:ari/services/hooks/useApiConfig.dart';
import 'package:ari/services/hooks/useDioRequest.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

ApiResponse<List<LatLng>> useZoneService() {
  final ApiConfig apiConfig = useApiConfig();
  final DioConfig dioConfig = useMemoized(() => DioConfig<List<LatLng>>(
      path: apiConfig.FETCH_MAP_ZONE(),
      transformResponse: (Response response) {
        return listLatlngFromJson(response.data['zone']);
      }));
  ApiResponse<List<LatLng>> apiResponse =
      useDioRequest<List<LatLng>>(dioConfig);
  return apiResponse;
}

listLatlngFromJson(List<dynamic> latLngList) {
  return List<LatLng>.from(latLngList.map((e) => LatLng(
      double.parse(e.toString().trim().split(',')[0]),
      double.parse(e.toString().trim().split(',')[1]))));
}
