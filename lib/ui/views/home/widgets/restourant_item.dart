import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:flutter/material.dart';
import 'package:ari/utils/size_config.dart';

class RestourantItem extends StatelessWidget {
  Restourant restourant;

  RestourantItem({this.restourant});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: Stack(
        children: [
          Container(
            width: SizeConfig().screenWidth / 2.4,
            height: SizeConfig().screenWidth / 2.4,
            margin: EdgeInsets.all(4.toWidth),
            decoration: BoxDecoration(
                color: Color(0xFF707070).withOpacity(0.21),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 7,
                  child: Container(
                      width: SizeConfig().screenWidth,
                      child: ClipRRect(
                          child: Image.network(restourant.image,
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.toWidth, vertical: 8.toHeight),
                      alignment: Alignment.topLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            restourant.name ?? 'No name',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 3.toHeight,
                          ),
                          Expanded(
                            child: Text(
                              restourant.information ?? 'No description',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.toFont),
                            ),
                          )
                        ],
                      )),
                )
              ],
            ),
          ),
          restourant.sticker != null && restourant.sticker.isNotEmpty
              ? Positioned(
                  child: Image.network(
                    restourant.sticker,
                    width: 60,
                    height: 60,
                  ),
                  top: 0,
                  left: 2,
                  //right: 0,
                )
              : SizedBox()
        ],
      ),
      onTap: () {
        pushRouteWithName(ROUTE_RESTAURANT,
            arguments: RouteArguments<Restourant>(
                data: Restourant(
                    image: restourant.image,
                    id: restourant.id,
                    name: restourant.name,
                    working: restourant.working,
                    information: restourant.information,
                    sticker: restourant.sticker,
                    sticker_text: restourant.sticker_text,
                    sticker_st_color: restourant.sticker_st_color,
                    sticker_en_color: restourant.sticker_en_color,
                    priceRange: restourant.priceRange,
                    minprice: restourant.minprice,percent: restourant.percent),));
      },
    );
  }
}
