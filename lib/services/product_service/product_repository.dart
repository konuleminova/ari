import 'package:ari/business_logic/models/product.dart';
import 'package:ari/services/api_helper/api_base_helper.dart';
import 'package:ari/services/api_config.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/product_service/product_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProductRepository implements ProductService {
  ApiBaseHelper _helper = ApiBaseHelper();

  final ValueNotifier<dynamic> _state =
      useState<ApiResponse<Product>>(ApiResponse.initial());

  @override
  ApiResponse<Product> fetchExchangeRates() {
    ApiResponse<Product> apiResponse = ApiResponse.loading();
    useEffect(() {
      _helper.get(ApiConfig().BASE_URl).then((value) {
        apiResponse = ApiResponse.completed(Product.fromJson(value));
        print('Api response');
        print(apiResponse);
        _state.value = apiResponse;
      });

      return () {};
    }, []);
    return _state.value;
  }
}
