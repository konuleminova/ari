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
    UniqueKey uniqueKey}) {
  final ApiConfig apiConfig = useApiConfig();
  final DioConfig dioConfig = useMemoized(() {
    print('ADD to bag');
    if (uniqueKey != null) {
      return DioConfig<PaymentResponse>(
        path: apiConfig.ADD_TO_BAG(
            address, coords, jsonString, restId, SpUtil.getString(SpUtil.token)),
        transformResponse: (Response response) {
          return PaymentResponse.fromJsom(response.data);
        },);
    }
    return null;
  },[uniqueKey]);
  ApiResponse<PaymentResponse> apiResponse =
      useDioRequest<PaymentResponse>(dioConfig);
  return apiResponse;
}
