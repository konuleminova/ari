import 'package:ari/business_logic/models/status.dart';
import 'package:ari/services/api_helper/api_config.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/api_helper/dio_config.dart';
import 'package:ari/services/hooks/useApiConfig.dart';
import 'package:ari/services/hooks/useDioRequest.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ApiResponse<StatusModel> useStatus() {
  ApiConfig apiConfig = useApiConfig();
  DioConfig dioConfig = useMemoized(() {
    if (SpUtil.getString(SpUtil.token).isEmpty) return null;
    return DioConfig<StatusModel>(
        path: apiConfig.STATUS(SpUtil.getString(SpUtil.token)),
        transformResponse: (Response response) {
          return StatusModel.fromJson(response.data);
        });
  });

  ApiResponse<StatusModel> apiResponse = useDioRequest(dioConfig);
  return apiResponse;
}
