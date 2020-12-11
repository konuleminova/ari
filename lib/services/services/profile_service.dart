import 'package:ari/business_logic/models/status.dart';
import 'package:ari/services/api_helper/api_config.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/api_helper/dio_config.dart';
import 'package:ari/services/hooks/useApiConfig.dart';
import 'package:ari/services/hooks/useDioRequest.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ApiResponse<dynamic> useUserPage() {
  ApiConfig apiConfig = useApiConfig();
  DioConfig dioConfig = useMemoized(() {
    return DioConfig<dynamic>(
        path: apiConfig.PROFILE_URL(SpUtil.getString(SpUtil.token)),
        transformResponse: (Response response) {
          if(response.data['found']>0){
            return StatusModel.fromJson(response.data);
          }
          return AppException(message: response.data['message']);

        });
  });
  ApiResponse<dynamic> apiResponse = useDioRequest(dioConfig);
  return apiResponse;
}
