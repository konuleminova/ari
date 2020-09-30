import 'package:ari/services/product_service/product_service.dart';
import 'package:ari/services/product_service/product_repository.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setUpServiceLocator() {
  serviceLocator
      .registerLazySingleton<ProductService>(() => ProductRepository());
}
