import 'package:ari/ui/views/map/flutter_map.dart';
import 'package:ari/ui/views/map/searchplace.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
            child: Card(
              child: ListTile(
                title: FutureBuilder(
                    future: _getAddress(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return Text(
                        snapshot.hasData && snapshot.data != ""
                            ? snapshot.data
                            : "Please add new address",
                        style: TextStyle(color: Colors.grey),
                      );
                    }),
                trailing: IconButton(icon: Icon(Icons.edit), onPressed: null),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          Dialog(child: CustomSearchScaffold()));
                },
              ),
              elevation: 2,
            ),
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 8)),
        Expanded(child: MapPage1(),)
      ],
    );
  }

  _getAddress() async {
    SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
    return await sharedPrefUtil.getString(SharedPrefUtil.address);
  }
}
