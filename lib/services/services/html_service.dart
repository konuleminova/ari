import 'package:ari/business_logic/models/html.dart';
import 'package:ari/services/api_helper/api_config.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/api_helper/dio_config.dart';
import 'package:ari/services/hooks/useApiConfig.dart';
import 'package:ari/services/hooks/useDioRequest.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ApiResponse<HtmlModel> useFetchHtml(String url) {
  ApiConfig apiConfig = useApiConfig();
  DioConfig dioConfig = useMemoized(() => DioConfig<HtmlModel>(
      path: apiConfig.HTML_URL(url),
      transformResponse: (Response response) {
        return HtmlModel.fromJson(response.data);
      }));
  ApiResponse<HtmlModel> apiResponse = useDioRequest(dioConfig);
  return apiResponse;
}
