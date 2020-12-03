import 'dart:convert';

import 'package:ari/business_logic/models/checkout.dart';
import 'package:ari/business_logic/models/payment_request.dart';
import 'package:ari/business_logic/models/payment_response.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/hooks/use_callback.dart';
import 'package:ari/services/services/payment_service.dart';
import 'package:ari/ui/common_widgets/loading.dart';
import 'package:ari/ui/views/init.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari/utils/size_config.dart';

class PaymentViewModel extends HookWidget {
  Checkout checkout;

  PaymentViewModel({this.checkout});

  @override
  Widget build(BuildContext context) {
    var uniqueKey = useState<UniqueKey>();
    var address = useState<String>();
    var coords = useState<String>();
    ValueNotifier<List<PaymentItem>> paymentItems =
        useState<List<PaymentItem>>([]);
    var restId = useState<String>();
    ValueNotifier<List<Add>> adds = useState<List<Add>>();
    useEffect(() {
      print('USE EFFECt ${checkout.foodList}');
      address.value = checkout.address ?? 'Yeni yasamal';
      coords.value = checkout.coords ?? '40.3923,49.7950';
      restId.value = checkout.restourant.id;
      checkout.foodList.forEach((foodParent) {
        foodParent.foods.forEach((food) {
          if (food.adds.length > 0) {
            adds.value = [];
            food.adds.forEach((add) {
              if (add.selected) {
                adds.value.add(Add(
                    name: add.name,
                    price: add.price,
                    number: add.count.toString()));
              }
            });
          }
          paymentItems.value.add(PaymentItem(
              restid: restId.value,
              cid: food.id,
              number: food.count.toString(),
              adds: adds.value));
        });
      });

      return () {};
    }, [checkout]);

    ApiResponse<PaymentResponse> apiResponse = useAddtoBag(
        restId: restId.value,
        coords: coords.value,
        address: address.value,
        jsonString: jsonEncode(paymentItems.value),
        uniqueKey: uniqueKey.value);

    final paymentCallBack = useCallback(() {
      uniqueKey.value = new UniqueKey();
    }, [uniqueKey.value]);
    // TODO: implement build
    return apiResponse.status == Status.Idle
        ? InkWell(
            onTap: () {
              print('here callback');
              paymentCallBack.call();
            },
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: ThemeColor().grey1),
                  color: ThemeColor().yellowColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                height: 56.toHeight,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Go to payment',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 19.toFont),
                    ),
                    Text(
                      '${checkout.totalPrice} ₼',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 19.toFont),
                    )
                  ],
                )))
        : apiResponse.status == Status.Loading
            ? Container(
                child: Loading(),
                margin: EdgeInsets.only(bottom: 8.toHeight),
              )
            : Dialog(
                child: Container(
                    height: SizeConfig().screenHeight / 1.4,
                    width: SizeConfig().screenWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          iconSize: 24.toHeight,
                          icon: Icon(
                            Icons.clear,
                            color: ThemeColor().greenColor,
                          ),
                          onPressed: () {
                            navigationKey.currentState.pop(context);
                          },
                        ),
                        Expanded(
                            child: Center(
                          child: Text(apiResponse.data.urltogo ?? ''),
                        ))
                      ],
                    )),
              );
  }
}
