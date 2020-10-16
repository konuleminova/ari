import 'package:ari/services/api_helper/dio_config.dart';
import 'package:ari/business_logic/models/product.dart';
import 'package:ari/services/hooks/useDioRequest.dart';
import 'package:ari/services/api_helper/api_config.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ApiConfig useApiConfig() {
  return useMemoized(() => new ApiConfig(), []);
}
ApiResponse<Product> useFetchProducts() {
  final ApiConfig apiConfig = useApiConfig();
  final DioConfig<Product> dioConfig = useMemoized(() => DioConfig(
      path: apiConfig.BASE_URl,
      transformResponse: (Response response) =>
          Product.fromJson(response.data)));
  ApiResponse<Product> response = useDioRequest<Product>(dioConfig);
  return response;
}
