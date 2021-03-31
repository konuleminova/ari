import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/business_logic/models/search.dart';
import 'package:ari/localization/app_localization.dart';
import 'package:ari/ui/views/home/widgets/restourant_item.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  final Search search;
  TextEditingController controller1;
  TextEditingController controller2;
  Function onChangeValue;

  SearchView(
      {this.search, this.controller1, this.controller2, this.onChangeValue});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 16.toHeight,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.toWidth),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4)),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                      padding: EdgeInsets.only(left: 8.toWidth),
                      child: TextField(
                        controller: controller1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onSubmitted: (v) {
                          onChangeValue();
                        },
                      )),
                  flex: 3,
                ),
//                VerticalDivider(
//                  width: 3,
//                  color: Colors.grey,
//                ),
//                SizedBox(
//                  width: 12.toWidth,
//                ),
//                Expanded(
//                  child: Container(
//                      child: TextField(
//                    controller: controller2,
//                    decoration: InputDecoration(
//                      border: InputBorder.none,
//                    ),
//                    keyboardType: TextInputType.numberWithOptions(
//                        signed: true, decimal: true),
//                    onSubmitted: (v) {
//                      onChangeValue();
//                    },
//                  )),
//                )
              ],
            ),
            height: 40.toHeight,
          ),
          SizedBox(
            height: 16.toHeight,
          ),
          search != null
              ? Expanded(
                  child: Column(
                    children: <Widget>[
                      Text('${search.message ?? ''}'),
                      SizedBox(
                        height: 4.toHeight,
                      ),
                      Expanded(
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.toWidth, vertical: 8.toHeight),
                            width: MediaQuery.of(context).size.width,
                            child:ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                return RestourantItem(
                                    restourant: Restourant(
                                        id: search.results[index].id,
                                        image: search.results[index].image,
                                        name: search.results[index].name,
                                        sm_name: search.results[index].sm_name,
                                        information:
                                            search.results[index].information),
                                width:SizeConfig().screenWidth,
                                height: 260,);
                              },
                              padding: EdgeInsets.all(0),
                              itemCount: search.results.length,
                            )),
                      )
                    ],
                  ),
                )
              : Center(
                  child: Text(
                      AppLocalizations.of(context).translate("No data") ??
                          "No data"),
                )
        ],
      ),
      height: SizeConfig().screenHeight,
    );
  }
}
