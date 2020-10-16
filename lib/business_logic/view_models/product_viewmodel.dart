import 'package:ari/business_logic/models/product.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/hooks/useSideEffect.dart';
import 'package:ari/services/services/product_service.dart';
import 'package:ari/ui/views/product_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ProductViewModel extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ApiResponse<Product> response = useFetchProducts();
    final BuildContext ctx = useContext();

    print('---CONTEXT---');
    print(ctx);
    print(context);

    useSideEffect(() {
      if(context != null && response.status == Status.Error) {
        print(context);
        showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
                child: Container(
                  color: Colors.red,
                ),
              ));
      }

      return () {};
    }, [response, context]);

    return ProductView(response.status, response.data?.number.toString());
  }
}
