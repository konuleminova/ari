import 'package:ari/ui/common_widgets/custom_appbar.dart';
import 'package:ari/ui/utils/size_config.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: Color(0xfffccd13),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: SizeConfig().screenWidth,
                height: SizeConfig().screenHeight,
                child: Center(
                  child: Text('text'),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            ),
            Container(
              height: 44.toHeight,
              child: Center(child: Text('© Ari 2020 by Delivery Group'),)
            )
          ],
        ));
  }
}
