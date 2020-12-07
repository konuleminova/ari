import 'package:ari/business_logic/models/user.dart';
import 'package:ari/services/api_helper/api_config.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/api_helper/dio_config.dart';
import 'package:ari/services/hooks/useApiConfig.dart';
import 'package:ari/services/hooks/useDioRequest.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ApiResponse<User> useLogin(User user,UniqueKey uniqueKey) {
  ApiConfig apiConfig = useApiConfig();
  DioConfig dioConfig = useMemoized(() {
    if (user.login.isEmpty && user.pass.isEmpty) return null;
    return DioConfig<User>(
        path: apiConfig.LOGIN_URL(user),
        transformResponse: (Response response) => User.fromJson(response.data));
  },[user,uniqueKey]);
  ApiResponse<User> apiResponse=useDioRequest(dioConfig);

  return apiResponse;
}

ApiResponse<User> useRegister(User user,UniqueKey uniqueKey) {
  ApiConfig apiConfig = useApiConfig();
  DioConfig dioConfig = useMemoized(() {
    if (user.login.isEmpty && user.pass.isEmpty) return null;
    return DioConfig<User>(
        path: apiConfig.REGISTER_URL(user),
        transformResponse: (Response response) => User.fromJson(response.data));
  },[user,uniqueKey]);
  ApiResponse<User> apiResponse=useDioRequest(dioConfig);

  return apiResponse;
}