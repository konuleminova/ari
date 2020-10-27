import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/business_logic/models/search.dart';
import 'package:ari/services/api_helper/api_config.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/api_helper/dio_config.dart';
import 'package:ari/services/hooks/useApiConfig.dart';
import 'package:ari/services/hooks/useDioRequest.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ApiResponse<Search> useSearchList(String query, String maxNum) {
  ApiConfig apiConfig = useApiConfig();
  print(apiConfig.SEARCH_URL(query, maxNum));
  DioConfig dioConfig = useMemoized(() => DioConfig<Search>(
      path: apiConfig.SEARCH_URL(query, maxNum),
      transformResponse: (Response response) =>
          Search.fromJson(response.data)));
  ApiResponse<Search> apiResponse = useDioRequest(dioConfig);
  return apiResponse;
}
