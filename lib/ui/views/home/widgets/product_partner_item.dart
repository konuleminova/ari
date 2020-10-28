import 'package:ari/utils/size_config.dart';
import 'package:flutter/material.dart';

class PartnerItem extends StatelessWidget {
  final index;

  PartnerItem(this.index);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: SizeConfig().screenWidth / 2,
      padding: EdgeInsets.symmetric(horizontal: 3.toWidth),
      child: Stack(
        children: <Widget>[
          Container(
              child: ClipRRect(
                  child: Image.network(
                      'https://bees.az/___entcpanel/uploads/ef4534a27895456ef72f5acd7703ec9f_331778.png',
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4)))),
          Positioned(
            bottom: 34.toHeight,
            left: 0,
            right: 0,
            child: Container(
                padding: EdgeInsets.all(10.toHeight),
                width: SizeConfig().screenWidth,
                alignment: index % 2 == 0
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(4),
                        bottomLeft: Radius.circular(4)),
                    image: DecorationImage(
                        image: index % 2 == 0
                            ? AssetImage(
                                'assets/images/2-0.jpg',
                              )
                            : AssetImage('assets/images/3-0.jpg'),
                        fit: BoxFit.cover)),
                child: Text(
                  'Cup Cup Coffie',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }
}
