import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/ui/common_widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ari/utils/size_config.dart';

class ErrorHandler extends StatelessWidget {
  Widget child;
  Status status;
  AppException error;

  ErrorHandler({this.child, this.status, this.error});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (status == Status.Loading) {
      child = Loading();
    } else if (status == Status.Error) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        showDialog(
            context: context,
            builder: (BuildContext context) => ErrorDialog(
                  errorMessage: error.message ?? "Some Message",
                ));
      });
      child=Container();
    }
    return child;
  }
}

class ErrorDialog extends StatelessWidget {
  String errorMessage;

  ErrorDialog({this.errorMessage});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.all(16.toHeight),
          height: 140.toHeight,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Center(
              child: Column(
            children: <Widget>[
              Text(errorMessage ?? 'Some Unkown Error Occured.'),
              SizedBox(
                height: 16.toHeight,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.toWidth),
                child: RaisedButton(
                  color: Colors.green,
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                width: SizeConfig().screenWidth,
              )
            ],
          )),
        ));
  }
}