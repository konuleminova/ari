import 'dart:async';
import 'dart:io';
import 'package:ari/business_logic/models/status.dart';
import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/business_logic/routes/nested_root.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/business_logic/view_models/status_viewmodel.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/hooks/useSideEffect.dart';
import 'package:ari/services/services/status_service.dart';
import 'package:ari/ui/common_widgets/custom_appbar.dart';
import 'package:ari/ui/provider/app_bar/app_bar_state.dart';
import 'package:ari/ui/provider/change_language/change_language_state.dart';
import 'package:ari/ui/views/menu/menu_view.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

class InitPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    //STORES
    final langStore = getLanguageStore();
    final appBarStore = getAppBarStore();

    ApiResponse<StatusModel> apiResponse =
        useStatus(appBarStore.state.uniqueKey);
    ValueNotifier<List<Widget>> widgets = useState<List<Widget>>([]);

    useEffect(() {
      widgets.value.clear();
      //Adding Main widget
      widgets.value.add(
        Scaffold(
            resizeToAvoidBottomPadding: true,
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
                        routes: routeNames,
                      ),
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
      if (apiResponse.status == Status.Done) {
        if (SpUtil.getString(SpUtil.token).isNotEmpty &&
            apiResponse.data != null) {
          for (int i = 0; i < apiResponse.data.found; i++) {
            widgets.value.add(StatusViewModel(i, apiResponse));
          }
        }
      }
      return () {};
    }, [apiResponse.status, langStore.state.lang, appBarStore.state]);

    SizeConfig().init(context);
    // TODO: implement build
    return Stack(
      children: widgets.value,
    );
  }
}
