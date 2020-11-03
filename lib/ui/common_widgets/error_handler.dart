import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/hooks/useSideEffect.dart';
import 'package:ari/ui/common_widgets/loading.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomErrorHandler extends HookWidget {
  final List<Status> statuses;
  final List<AppException> errors;
  final Widget child;
  final Function onRefresh;

  const CustomErrorHandler(
      {this.statuses, this.child, this.errors, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final AppException error =
        errors.firstWhere((element) => element != null, orElse: () => null);
    final bool hasError = error != null;
    final bool isLoading = statuses.firstWhere(
            (element) => element == Status.Loading,
            orElse: () => null) !=
        null;
    final ctx = useContext();
    useSideEffect(() {
      if (hasError) {
        showDialog(
            context: ctx,
            builder: (BuildContext context) => ErrorDialog(
                  errorMessage: error.message ?? "Some Message",
                ));
      }

      return () {};
    }, [hasError, error]);

    return hasError
        ? Container(
            child: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.refresh,
                      color: ThemeColor().greenColor,
                      size: 24.toFont,
                    ),
                    SizedBox(
                      height: 8.toHeight,
                    ),
                    Text(
                      'Tap to refresh',
                      style: TextStyle(
                          color: ThemeColor().greenColor, fontSize: 16.toFont),
                    )
                  ],
                ),
                onTap: onRefresh))
        : isLoading ? Loading() : child;
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
          // height: 140.toHeight,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Center(
              child: Column(
            children: <Widget>[
              Expanded(
                child: Text(errorMessage ?? 'Some Unkown Error Occured.'),
              ),
              SizedBox(
                height: 16.toHeight,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.toWidth),
                height: 34.toHeight,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: ThemeColor().yellowColor,
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
