import 'package:flutter/material.dart';
import 'package:ari/utils/size_config.dart';

class ProductzItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: SizeConfig().screenWidth / 2.4,
      margin: EdgeInsets.all(4.toWidth),
      decoration: BoxDecoration(
          color: Color(0xFF707070).withOpacity(0.21),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
                child: ClipRRect(
                    child: Image.network(
                      'https://bees.az/___entcpanel/uploads/d3271c371aae25d4f8c747912391ce93_206431.png',
                      fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)))),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16.toWidth,vertical: 4.toHeight),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Simple Text'),
                  Text("Info some ",style: TextStyle(fontFamily: 'Bitter-Light'),),
                ],
              )),
        ],
      ),
    );
  }
}
