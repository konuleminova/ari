import 'package:ari/business_logic/models/status.dart';
import 'package:ari/business_logic/models/user.dart';
import 'package:ari/services/api_helper/api_config.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/api_helper/dio_config.dart';
import 'package:ari/services/hooks/useApiConfig.dart';
import 'package:ari/services/hooks/useDioRequest.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ApiResponse<dynamic> useLogin(User user, UniqueKey uniqueKey) {
  ApiConfig apiConfig = useApiConfig();
  DioConfig dioConfig = useMemoized(() {
    if (user.login.isEmpty && user.pass.isEmpty) return null;
    return DioConfig<dynamic>(
        path: apiConfig.LOGIN_URL(user),
        transformResponse: (Response response) {
          if (response.data['error'] == '1') {
            return AppException(message: response.data['message']);
          }
          return User.fromJson(response.data);
        });
  }, [user, uniqueKey]);
  ApiResponse<dynamic> apiResponse = useDioRequest(dioConfig);

  return apiResponse;
}

ApiResponse<dynamic> useRegister(User user, UniqueKey uniqueKey) {
  ApiConfig apiConfig = useApiConfig();
  DioConfig dioConfig = useMemoized(() {
    if (user.login.isEmpty && user.pass.isEmpty) return null;
    return DioConfig<dynamic>(
        path: apiConfig.REGISTER_URL(user),
        transformResponse: (Response response) {
          if (response.data is List) {
            return AppException(message: response.data[0]['errlist'][0]);
          }
          return User.fromJson(response.data);
        });
  }, [user, uniqueKey]);
  ApiResponse<dynamic> apiResponse = useDioRequest(dioConfig);

  return apiResponse;
}

ApiResponse<dynamic> useUserPage() {
  ApiConfig apiConfig = useApiConfig();
  DioConfig dioConfig = useMemoized(() {
    return DioConfig<dynamic>(
        path: apiConfig.PROFILE_URL(SpUtil.getString(SpUtil.token)),
        transformResponse: (Response response) {
          if (response.data['found'] != null) {
            if (response.data['found'] > 0) {
              return StatusModel.fromJson(response.data);
            }
          }
          return AppException(message: response.data['message']);
        });
  });

  ApiResponse<dynamic> apiResponse = useDioRequest(dioConfig);
  if (apiResponse.data is AppException) {
    AppException exception = apiResponse.data;
    if (exception.message.toString() == 'token not found') {
      apiResponse.error = apiResponse.data;
    }
  }
  return apiResponse;
}
