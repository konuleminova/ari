import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/services/api_helper/api_config.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/api_helper/dio_config.dart';
import 'package:ari/services/hooks/useApiConfig.dart';
import 'package:ari/services/hooks/useDioRequest.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ApiResponse<RestourantList> useFetchRestourants(String id,
    {UniqueKey key, String lang}) {
  ApiConfig apiConfig = useApiConfig();
  final token = SpUtil.getString(SpUtil.token).isEmpty
      ? null
      : SpUtil.getString(SpUtil.token);
  final DioConfig dioConfig = useMemoized(
      () => DioConfig<RestourantList>(
            path: apiConfig.RESTOURANT_URl(id, lang, token),
            transformResponse: (Response response) =>
                RestourantList.fromJson(response.data),
          ),
      [key, lang]);
  ApiResponse<RestourantList> apiResponse =
      useDioRequest<RestourantList>(dioConfig);
  return apiResponse;
}
