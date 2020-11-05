import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/business_logic/routes/nested_root.dart';
import 'package:ari/ui/common_widgets/custom_appbar.dart';
import 'package:ari/ui/common_widgets/drawer.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
final _scaffoldKey = GlobalKey<ScaffoldState>();

class InitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Scaffold(
        key: _scaffoldKey,
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
                        child: Text(
                          '© Ari 2020 by Delivery Group',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.toFont),
                        ),
                      )),
                  onTap: () {
                    navigationKey.currentState.pushNamed(ROUTE_SEARCH);
                  },
                )
              ],
            ),
            Positioned(
                right: 0,
                bottom: 140.toHeight,
                child: InkWell(
                  child: Container(
                    child: Image.asset(
                      'assets/images/menu.png',
                      height: 80.toWidth,
                      width: 80.toWidth,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  onTap: () {
                    //Scaffold.of(context).openEndDrawer();
                    //_scaffoldKey.currentState.openEndDrawer();

//                    showDialog(
//                        context: context,
//                        builder: (BuildContext context) => DrawerWidget());

                    showGeneralDialog(
                      barrierLabel: "Label",
                      barrierDismissible: true,
                      barrierColor: Colors.black.withOpacity(0.4),
                      transitionDuration: Duration(milliseconds: 700),
                      context: context,
                      pageBuilder: (context, anim1, anim2) {
                        return Stack(
                          children: <Widget>[
                            Positioned(
                                top:CustomAppBar().preferredSize.height+30.toHeight,
                                left: 0,
                                right: 0,
                                child:Align(child: DrawerWidget(onClose: (){
                                  Navigator.pop(context);
                                },),alignment: Alignment.bottomRight,)
                            )
                          ],
                        );
                      },
                      transitionBuilder: (context, anim1, anim2, child) {
                        return SlideTransition(
                          position:
                              Tween(begin: Offset(1, 0), end: Offset(0.085, 0))
                                  .animate(anim1),
                          child: child,
                        );
                      },
                    );
                  },
                ))
          ],
        ));
  }
}
