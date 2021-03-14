import 'package:ari/business_logic/models/status.dart';
import 'package:ari/services/api_helper/api_config.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/api_helper/dio_config.dart';
import 'package:ari/services/hooks/useApiConfig.dart';
import 'package:ari/services/hooks/useDioRequest.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ApiResponse<StatusModel> useStatus(UniqueKey uniqueKey) {
  ApiConfig apiConfig = useApiConfig();
  DioConfig dioConfig = useMemoized(() {
    if (SpUtil.getString(SpUtil.token).isEmpty || uniqueKey == null)
      return null;
    return DioConfig<StatusModel>(
      path: apiConfig.STATUS(SpUtil.getString(SpUtil.token)),
      transformResponse: (Response response) {
        return StatusModel.fromJson(response.data);
      },
    );
  }, [uniqueKey]);

  ApiResponse<StatusModel> apiResponse = useDioRequest(dioConfig);
  return apiResponse;
}

ApiResponse<String> useGetCuryerCoords(UniqueKey uniqueKey, var cid) {
  ApiConfig apiConfig = useApiConfig();
  DioConfig dioConfig = useMemoized(() {
    if (SpUtil.getString(SpUtil.token).isEmpty ||
        uniqueKey == null ||
        cid == null||cid.isEmpty) return null;
    return DioConfig<String>(
      path: apiConfig.GET_CURYER_COORDS(SpUtil.getString(SpUtil.token), cid),
      transformResponse: (Response response) {
        return response.data['coords'];
      },
    );
  }, [uniqueKey,cid]);

  ApiResponse<String> apiResponse = useDioRequest(dioConfig);
  return apiResponse;
}
