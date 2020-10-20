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
      padding: EdgeInsets.symmetric(horizontal: 4.toWidth),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
                child: ClipRRect(
                    child: Image.network(
                        'https://bees.az/___entcpanel/uploads/d3271c371aae25d4f8c747912391ce93_206431.png',
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)))),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.toWidth),
              width: SizeConfig().screenWidth,
                alignment: index % 2 == 0?Alignment.centerRight:Alignment.centerLeft,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image:index % 2 == 0
                      ? AssetImage('assets/images/green_clipper.png',)
                      : AssetImage('assets/images/green_clipper_right.png'),
                )),
                child: Text('Cup Cup Coffie',textAlign: TextAlign.center,)),
          )
        ],
      ),
    );
  }
}
