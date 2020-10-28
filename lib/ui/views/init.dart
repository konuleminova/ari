import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/business_logic/routes/nested_root.dart';
import 'package:ari/ui/common_widgets/custom_appbar.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

class InitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Scaffold(
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
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                )),
                GestureDetector(
                  child: Container(
                      height: 44.toHeight,
                      child: Center(
                        child: Text('© Ari 2020 by Delivery Group'),
                      )),
                  onTap: () {
                    navigationKey.currentState.pushNamed(ROUTE_SEARCH);
                  },
                )
              ],
            ),
            Positioned(
                right: 0,
                bottom: 200.toHeight,
                child: Container(
                  child: Image.asset(
                    'assets/images/menu.png',
                    height: 80.toWidth,
                    width: 80.toWidth,
                    alignment: Alignment.centerRight,
                  ),
                ))
          ],
        ));
  }
}
