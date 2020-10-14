import 'package:ari/services/api_helper/api_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductView extends StatelessWidget {
  final Status status;
  final String result;

  ProductView(this.status,this.result);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: status == Status.Loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(child:Center(child:  Text(result??"Test result"),)),
    );
  }
}
