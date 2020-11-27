import 'package:ari/business_logic/models/food.dart';
import 'package:ari/services/api_helper/api_config.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/api_helper/dio_config.dart';
import 'package:ari/services/hooks/useApiConfig.dart';
import 'package:ari/services/hooks/useDioRequest.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dio/dio.dart';

ApiResponse<List<GroupFood>> useFetchFoods(String id) {
  final ApiConfig apiConfig = useApiConfig();
  final DioConfig dioConfig = useMemoized(() => DioConfig<List<GroupFood>>(
      path: apiConfig.FOOD_URl(id),
      transformResponse: (Response response) {
       // print('FOOD RESPONSE: ${response.data}');
        return listGroupFoodFromJson(response.data);
      }));
  ApiResponse<List<GroupFood>> apiResponse = useDioRequest<List<GroupFood>>(dioConfig);
  return apiResponse;
}
