import 'dart:convert';
import 'package:ari/business_logic/models/status.dart';
import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/localization/app_localization.dart';
import 'package:ari/services/provider/provider.dart';
import 'package:ari/services/services/status_service.dart';
import 'package:ari/ui/provider/checkout/checkout_action.dart';
import 'package:ari/ui/provider/checkout/checkout_state.dart';
import 'package:ari/ui/views/init.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:flutter/scheduler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ari/business_logic/models/checkout.dart';
import 'package:ari/business_logic/models/payment_request.dart';
import 'package:ari/business_logic/models/payment_response.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/hooks/use_callback.dart';
import 'package:ari/services/services/payment_service.dart';
import 'package:ari/ui/common_widgets/loading.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari/utils/size_config.dart';

class PaymentViewModel extends HookWidget {
  Checkout checkout;

  PaymentViewModel({this.checkout});

  @override
  Widget build(BuildContext context) {
    var store = useProvider<Store<CheckoutState, CheckoutAction>>();
    if (SpUtil.getBool(SpUtil.isPointInPolygon)) {
      store.state.isInPolygon = true;
    }
    var uniqueKey = useState<UniqueKey>();
    var address = useState<String>();
    var coords = useState<String>();
    ValueNotifier<List<PaymentItem>> paymentItems =
        useState<List<PaymentItem>>([]);
    var restId = useState<String>();
    ValueNotifier<List<Add>> adds = useState<List<Add>>();

    useEffect(() {
      print('USE EFFECt ${checkout.foodList}');
      paymentItems.value.clear();
      address.value = store.state?.address ?? '';
      coords.value = store.state.coords ?? '';
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
    }, [checkout, store.state]);

    ApiResponse<PaymentResponse> apiResponse = useAddtoBag(
        restId: restId.value,
        coords: coords.value,
        address: address.value,
        jsonString: jsonEncode(paymentItems.value),
        uniqueKey: uniqueKey.value);

    final paymentCallBack = useCallback(() {
      uniqueKey.value = new UniqueKey();
    }, [uniqueKey.value]);
    useEffect(() {
      if (apiResponse.status == Status.Done) {
        print(apiResponse.data.urltogo);
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          showGeneralDialog(
            barrierLabel: "Label",
            barrierDismissible: false,
            barrierColor: Colors.black.withOpacity(0.5),
            transitionDuration: Duration(milliseconds: 700),
            context: context,
            pageBuilder: (context, anim1, anim2) {
              return Material(
                  color: Colors.transparent,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: SizeConfig().screenHeight - 44.toHeight,
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(
                          bottom: 0, left: 8.toWidth, right: 8.toWidth),
                      // color: Colors.white,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xffffffff)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                child: Padding(
                                  child: CircleAvatar(
                                    radius: 18,
                                    foregroundColor: Colors.white,
                                    backgroundColor: ThemeColor().grey1,
                                    child: Icon(Icons.clear),
                                  ),
                                  padding: EdgeInsets.only(
                                      top: 10, right: 10, bottom: 10),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  SchedulerBinding.instance
                                      .addPostFrameCallback((_) {
                                    // fetch data

                                    SpUtil.putString(
                                            SpUtil.isFromMap, 'isFromMap')
                                        .then((value) {
                                      pushRouteWithName('/',
                                          arguments:
                                              RouteArguments<bool>(data: true));
                                    });
                                  });
                                  //navigationKey.currentState.pushNamedAndRemoveUntil(ROUTE_INIT,(Route<dynamic> route) => false);
                                },
                              ),
                              Expanded(
                                child: WebView(
                                  javascriptMode: JavascriptMode.unrestricted,
                                  javascriptChannels: <JavascriptChannel>[
                                    _toasterJavascriptChannel(context),
                                  ].toSet(),
                                  initialUrl: apiResponse.data.urltogo ??
                                      'https://bees.az//payment//',
                                ),
                              )
                            ],
                          )),
                    ),
                  ));
            },
            transitionBuilder: (context, anim1, anim2, child) {
              return SlideTransition(
                position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                    .animate(anim1),
                child: child,
              );
            },
          );
        });
      }
      return () {};
    }, [apiResponse.status]);
    // TODO: implement build
    return apiResponse.status != Status.Loading
        ? InkWell(
            onTap: () {
              print('here callback');
              if (store.state.isInPolygon) {
                paymentCallBack.call();
              }
            },
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: ThemeColor().grey1),
                  color: store.state.isInPolygon
                      ? ThemeColor().yellowColor
                      : ThemeColor().grey1,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                height: 56.toHeight,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context).translate('Go to payment') ??
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
        : Container(
            child: Loading(),
            margin: EdgeInsets.only(bottom: 8.toHeight),
          );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
