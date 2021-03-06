import 'package:ari/business_logic/models/delivery.dart';
import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/payment_response.dart';
import 'package:ari/services/api_helper/api_config.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/api_helper/dio_config.dart';
import 'package:ari/services/hooks/useApiConfig.dart';
import 'package:ari/services/hooks/useDioRequest.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ApiResponse<PaymentResponse> useAddtoBag(
    {String address,
    String coords,
    String jsonString,
    String restId,
    String additionalAddress,
    UniqueKey uniqueKey}) {
  final ApiConfig apiConfig = useApiConfig();
  final DioConfig dioConfig = useMemoized(() {
    if (uniqueKey != null) {
      return DioConfig<PaymentResponse>(
        path: apiConfig.ADD_TO_BAG(
          address,
          coords,
          jsonString,
          restId,
          additionalAddress,
          SpUtil.getString(SpUtil.token),
        ),
        transformResponse: (Response response) {
          return PaymentResponse.fromJsom(response.data);
        },
      );
    }
    return null;
  }, [uniqueKey]);
  ApiResponse<PaymentResponse> apiResponse =
      useDioRequest<PaymentResponse>(dioConfig);
  return apiResponse;
}

//Delivery price

ApiResponse<Delivery> useGetCuryerPrice(String restId) {
  ApiConfig apiConfig = useApiConfig();
  DioConfig dioConfig = useMemoized(() {
    return DioConfig<Delivery>(
        path:
            apiConfig.GET_CURYER_PRICE(SpUtil.getString(SpUtil.token), restId),
        transformResponse: (Response response) {
          return Delivery.fromJson(response.data);
        });
  });
  ApiResponse<Delivery> apiResponse = useDioRequest(dioConfig);
  return apiResponse;
}
