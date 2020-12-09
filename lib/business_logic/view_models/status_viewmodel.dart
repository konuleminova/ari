import 'dart:async';
import 'package:ari/business_logic/models/status.dart';
import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/services/status_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/views/init.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari/utils/size_config.dart';

class StatusViewModel extends HookWidget {
  Timer timer;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //get user status
    ApiResponse<StatusModel> apiResponse = useStatus();
    var offset = useState<List<Offset>>([]);
    var isOpen = useState<bool>(false);
    useEffect(() {
      if (apiResponse.status == Status.Done) {
        offset.value.clear();
        for (int i = 0; i < apiResponse.data.found; i++) {
          offset.value.add(Offset.zero);
          print('OFFSEt ${offset}');
          offset.notifyListeners();
        }
      }
      return () {};
    }, [apiResponse.status]);

    return SpUtil.getString(SpUtil.token).isNotEmpty && apiResponse.data != null
        ? CustomErrorHandler(
            errors: [apiResponse.error],
            statuses: [apiResponse.status],
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: offset.value.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Positioned(
                      left: offset.value[index].dx + 10,
                      top: offset.value[index].dy + 100,
                      right: 0,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          offset.value[index] = Offset(
                              offset.value[index].dx + details.delta.dx,
                              offset.value[index].dy + details.delta.dy);
                          //offset.notifyListeners();
                        },
                        onTap: () {
                          isOpen.value = !isOpen.value;
                          if (isOpen.value) {
                            pushRouteWithName(ROUTE_STATUS,
                                arguments: RouteArguments<Order>(
                                    data: apiResponse.data.order[index]));
                          } else {
                            navigationKey.currentState.pop(context);
                          }
                        },
                        child: Container(
                            width: 70.toWidth,
                            height: 70.toWidth,
                            margin: EdgeInsets.only(top: 16),
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: ThemeColor().yellowColor,
                                    width: 2.toHeight),
                                image: new DecorationImage(
                                    fit: BoxFit.contain,
                                    image: new NetworkImage(apiResponse
                                        .data.order[index].restourant.image)))),
                      ));
                }))
        : SizedBox();
  }
}

//    useEffect(() {
//      timer = Timer.periodic(Duration(seconds: 5), (timer) {
//        if (Platform.isAndroid) {
//
//        }
//      });
//      return () {};
//    });

//dragable widget offset
