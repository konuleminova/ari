import 'package:ari/business_logic/models/food.dart';
import 'package:ari/services/api_helper/api_config.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/api_helper/dio_config.dart';
import 'package:ari/services/hooks/useApiConfig.dart';
import 'package:ari/services/hooks/useDioRequest.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:dio/dio.dart';

ApiResponse<List<Food>> useFetchFoods(String id) {
  final ApiConfig apiConfig = useApiConfig();
  final DioConfig dioConfig = useMemoized(() => DioConfig<List<Food>>(
      path: apiConfig.FOOD_URl,
      transformResponse: (Response response) =>
          listFoodsFromJson(response.data)));
  ApiResponse<List<Food>> apiResponse = useDioRequest<List<Food>>(dioConfig);
  return apiResponse;
}
