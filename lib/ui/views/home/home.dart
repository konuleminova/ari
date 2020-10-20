import 'package:ari/ui/views/home/widgets/product_item.dart';
import 'package:ari/ui/views/home/widgets/product_partner_item.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: 8.toWidth, vertical: 8.toHeight),
          height: MediaQuery.of(context).size.height * 0.24,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ProductzItem();
            },
            itemCount: 5,
            scrollDirection: Axis.horizontal,
          ),
        ),
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: 8.toWidth, vertical: 8.toHeight),
          height: MediaQuery.of(context).size.height * 0.24,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return PartnerItem(index);
            },
            itemCount: 5,
            scrollDirection: Axis.horizontal,
          ),
        ),
        Container(
          padding:
          EdgeInsets.symmetric(horizontal: 8.toWidth, vertical: 8.toHeight),
          height: MediaQuery.of(context).size.height * 0.24,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ProductzItem();
            },
            itemCount: 5,
            scrollDirection: Axis.horizontal,
          ),
        ),
        Container(
          padding:
          EdgeInsets.symmetric(horizontal: 8.toWidth, vertical: 8.toHeight),
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ProductzItem();
            },
            itemCount: 5,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ],
    );
  }
}
