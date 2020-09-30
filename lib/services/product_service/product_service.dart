import 'package:ari/business_logic/models/product.dart';
import 'package:ari/services/api_helper/api_response.dart';
abstract class ProductService {
  ApiResponse<Product> fetchExchangeRates();
}