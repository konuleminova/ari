import 'package:ari/business_logic/models/product.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/product_service/product_repository.dart';
import 'package:ari/services/product_service/product_service.dart';
import 'package:ari/ui/views/product_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProductViewModel extends HookWidget {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<Status> productState = useState<Status>();
     String   resultText;
    useEffect(() {
      ProductRepository repository = new ProductRepository();
      ApiResponse<Product> fetchProducts = repository.fetchExchangeRates();
      productState.value = useMemoized(() =>  fetchProducts.status);
     resultText =
      useMemoized(() => fetchProducts?.data?.number.toString() ?? '');
      print('STTAe ');
print(productState.value);
      return () {};
    },[]);

    // TODO: implement build
    return ProductView(productState.value, resultText);
  }
}
