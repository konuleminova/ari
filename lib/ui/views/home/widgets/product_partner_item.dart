import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter/material.dart';

class PartnerItem extends StatelessWidget {
  Restourant restourant;
  int index;

  PartnerItem({this.restourant, this.index});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(child:Container(
      width: SizeConfig().screenWidth / 2.1,
      padding: EdgeInsets.symmetric(horizontal: 3.toWidth),
      child: Stack(
        children: <Widget>[
          Container(
              child: ClipRRect(
                  child: Image.network(restourant.image, fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4)))),
          Positioned(
            bottom: 34.toHeight,
            left: 0,
            right: 0,
            child: Container(
                padding: EdgeInsets.only(
                    bottom: 10.toHeight,
                    top: 10.toHeight,
                    right: index % 2 == 0?4.toWidth:36.toWidth,
                    left: index % 2 == 0 ? 36.toWidth : 0),
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
                  restourant.name ?? 'https://bees.az/___entcpanel/uploads/b06ec8c2148a83cc53dfe7e062e42572_1199.png',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),),
      onTap: (){
        pushRouteWithName(ROUTE_RESTAURANT,
            arguments: RouteArguments<Restourant>(
                data: Restourant(
                    image: restourant.image,
                    id: restourant.id,
                    name: restourant.name,
                    working: restourant.working,
                    information: restourant.information)));
      },
    );
  }
}
