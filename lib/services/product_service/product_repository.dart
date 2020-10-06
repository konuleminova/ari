import 'package:ari/business_logic/models/product.dart';
import 'package:ari/services/api_helper/api_base_helper.dart';
import 'package:ari/services/api_config.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/product_service/product_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:http/http.dart';


abstract class Task<T> {
  void cancel();

}



//class ProductService {
//  Dio dio = new Dio();
//  ApiConfig config = new ApiConfig();
//
//
//  Future<dynamic> fetchRates() {
//    dio.get(config.BASE_URl);
//  }
//}
//
//go() {
//  new ProductService().fetchRates();
//}
//
Dio useDio() {
  return useMemoized(() => new Dio(), []);
}

ApiConfig useApiConfig() {
  return useMemoized(() => new ApiConfig(), []);
}

ApiResponse<dynamic> useFetchRates() {
  final Dio dio = useDio();
  final ApiConfig config = useApiConfig();
  final ValueNotifier<ApiResponse<dynamic>> state = useState(ApiResponse.initial());

  useEffect(() {
    state.value = ApiResponse.loading();
    dio.get(config.BASE_URl)
        .then((value) => ApiResponse.completed(value))
        .catchError((e) => print('OKay'));
    return () {};
  }, []);

  return state.value;
}




class ProductRepository implements ProductService {
  ApiBaseHelper _helper = ApiBaseHelper();

  @override
  ApiResponse<Product> useFetchExchangeRates() {
    final ValueNotifier<ApiResponse<Product>> _state =
    useState<ApiResponse<Product>>(ApiResponse.initial());

    useEffect(() {
      _state.value = ApiResponse.loading();
      _helper.get(ApiConfig().BASE_URl).then((value) {
        _state.value = ApiResponse.completed(Product.fromJson(value));
        print('Api response ${_state.value}');
      });

      return () {
        print('DISPOSED');
      };
    }, []);
    print('VALUE ${_state.value}');
    return _state.value;
  }
}
