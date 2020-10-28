import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/business_logic/routes/route_names.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/ui/views/home/widgets/restourant_item.dart';
import 'package:ari/ui/views/home/widgets/product_partner_item.dart';
import 'package:ari/ui/views/init.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeView extends StatelessWidget {
  RestourantList restourantList1;
  RestourantList restourantList2;
  RestourantList restourantList3;

  HomeView({this.restourantList1, this.restourantList2, this.restourantList3});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 16.toHeight,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.toWidth,
          ),
          child: Text(restourantList1.text),
        ),
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: 8.toWidth, vertical: 8.toHeight),
          height: MediaQuery.of(context).size.height * 0.24,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return RestourantItem(
                restourant: restourantList1.results[index],
              );
            },
            itemCount: restourantList1.results.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: 16.toHeight,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.toWidth,
          ),
          child: Text(restourantList1.text),
        ),
        SizedBox(height: 8.toHeight,),
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: 8.toWidth,),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.25,
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemBuilder: (BuildContext context, int index) {
              return PartnerItem(index);
            },
            itemCount: 5,
            scrollDirection: Axis.horizontal,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.toWidth,
          ),
          child: Text(restourantList2.text),
        ),
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: 8.toWidth, vertical: 8.toHeight),
          height: MediaQuery.of(context).size.height * 0.24,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return RestourantItem(
                restourant: restourantList2.results[index],
              );
            },
            itemCount: restourantList2.results.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
        SizedBox(
          height: 16.toHeight,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.toWidth,
          ),
          child: Text(restourantList3.text),
        ),
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: 8.toWidth, vertical: 8.toHeight),
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return RestourantItem(
                restourant: restourantList3.results[index],
              );
            },
            itemCount: restourantList3.results.length,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
