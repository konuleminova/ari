import 'dart:async';
import 'dart:io';

import 'package:ari/business_logic/models/status.dart';
import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/business_logic/routes/nested_root.dart';
import 'package:ari/business_logic/view_models/status_viewmodel.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/services/status_service.dart';
import 'package:ari/ui/common_widgets/custom_appbar.dart';
import 'package:ari/ui/common_widgets/loading.dart';
import 'package:ari/ui/views/menu/menu_view.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

class InitPage extends HookWidget {
  Timer timer;

  @override
  Widget build(BuildContext context) {
    var uniqueKey=useState<UniqueKey>();
    ApiResponse<StatusModel> apiResponse = useStatus(uniqueKey.value);
    ValueNotifier<List<Widget>> widgets = useState<List<Widget>>([]);
    //Timer for getting status
    useEffect(() {
      timer = Timer.periodic(Duration(seconds: 5), (timer) {
        if (Platform.isAndroid) {
         // uniqueKey.value=new UniqueKey();
        }
      });
      return () {};
    },[uniqueKey.value]);
    useEffect(() {
      widgets.value.clear();
      //Adding Main widget
      widgets.value.add(
        Scaffold(
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            appBar: CustomAppBar(),
            backgroundColor: Color(0xfffccd13),
            body: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      width: SizeConfig().screenWidth,
                      height: SizeConfig().screenHeight,
                      child: NestedNavigator(
                          navigationKey: navigationKey,
                          initialRoute: '/',
                          routes: routeNames),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                    )),
                  ],
                ),
                MenuView(),
              ],
            )),
      );
      //Adding circle status Widgets
      if (apiResponse.status == Status.Done) {
        if (SpUtil.getString(SpUtil.token).isNotEmpty &&
            apiResponse.data != null) {
          for (int i = 0; i < apiResponse.data.found; i++) {
            widgets.value.add(StatusViewModel(i, apiResponse));
          }
        }
      }
      return () {};
    }, [apiResponse.status]);

    SizeConfig().init(context);
    // TODO: implement build
    return Stack(
      children: widgets.value,
    );
  }
}
