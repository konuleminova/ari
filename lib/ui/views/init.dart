import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/business_logic/routes/nested_root.dart';
import 'package:ari/business_logic/view_models/status_viewmodel.dart';
import 'package:ari/ui/common_widgets/custom_appbar.dart';
import 'package:ari/ui/views/menu/menu_view.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

class InitPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Stack(children: [Scaffold(
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
            StatusViewModel(),
          ],
        ))],);
  }
}
