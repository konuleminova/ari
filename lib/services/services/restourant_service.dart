import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/services/api_helper/api_config.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/api_helper/dio_config.dart';
import 'package:ari/services/hooks/useApiConfig.dart';
import 'package:ari/services/hooks/useDioRequest.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ApiResponse<RestourantList> useFetchRestourants(String id,{UniqueKey key}) {
  ApiConfig apiConfig = useApiConfig();
  //print(apiConfig.RESTOURANT_URl(id));
  final DioConfig dioConfig = useMemoized(() => DioConfig<RestourantList>(
      path: apiConfig.RESTOURANT_URl(id),
      transformResponse: (Response response) =>
          RestourantList.fromJson(response.data),),[key]);
  ApiResponse<RestourantList> apiResponse =
      useDioRequest<RestourantList>(dioConfig);
  return apiResponse;
}
