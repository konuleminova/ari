import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/hooks/useSideEffect.dart';
import 'package:ari/ui/common_widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class CustomErrorHandler extends HookWidget {
  final List<Status> statuses;
  final List<AppException> errors;
  final Widget child;

  const CustomErrorHandler({
    this.statuses,
    this.child,
    this.errors,
});

  @override
  Widget build(BuildContext context) {
    print('ERRORS: $errors');
    print('STATUSES: $statuses');
    final AppException error = errors.firstWhere((element) => element != null, orElse: () => null);
    final bool hasError = error != null;
    final bool isLoading = statuses.firstWhere((element) => element == Status.Loading, orElse: () => null) != null;

    final ctx = useContext();

    useSideEffect(() {
      if(hasError) {
        showDialog(
            context: ctx,
            builder: (BuildContext context) => ErrorDialog(
              errorMessage: error.message ?? "Some Message",
            ));
      }

      return () {};
    }, [hasError, error]);

    return hasError ? Container() : isLoading ? Loading() : child;
  }
}



class ErrorHandler extends StatelessWidget {
  Widget child;
  Status status;
  AppException error;

  ErrorHandler({this.child, this.status, this.error});

  @override
  Widget build(BuildContext context) {
    if (status == Status.Idle) {
      child = Container();
      return child;
    }
    // TODO: implement build
    if (status == Status.Loading) {
      child = Loading();
      return child;
    } else if (status == Status.Error) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        showDialog(
            context: context,
            builder: (BuildContext context) => ErrorDialog(
                  errorMessage: error.message ?? "Some Message",
                ));
      });
      child = Container(
//        child: RefreshIndicator(
//          child: Icon(Icons.refresh),
//          onRefresh: () {},
//        ),
      );
      return child;
    }else if(status==Status.Done){
      return child;
    }

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
