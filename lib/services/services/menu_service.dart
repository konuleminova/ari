import 'package:ari/business_logic/models/menu.dart';
import 'package:ari/services/api_helper/api_config.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/api_helper/dio_config.dart';
import 'package:ari/services/hooks/useApiConfig.dart';
import 'package:ari/services/hooks/useDioRequest.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ApiResponse<List<Menu>> useFetchMenu(String id) {
  final ApiConfig apiConfig = useApiConfig();
  final DioConfig dioConfig = useMemoized(() {
    //print('MENU CONFIG BUILDER WORKS');
    return DioConfig<List<Menu>>(
        path: apiConfig.MENU_URL(id),
        transformResponse: (Response response) =>
            menuListFromJson(response.data));

  }, [id, apiConfig]);

  ApiResponse<List<Menu>> apiResponse = useDioRequest<List<Menu>>(dioConfig);
  return apiResponse;
}
