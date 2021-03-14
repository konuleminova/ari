import 'package:ari/business_logic/models/html.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/services/html_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/common_widgets/loading.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class HtmlViewmModel extends HookWidget {
  RouteArguments<String> url;

  @override
  Widget build(BuildContext context) {
    url = ModalRoute.of(context).settings.arguments;

    ApiResponse<HtmlModel> apiResponse = useFetchHtml(url.data);
    // TODO: implement build
    return CustomErrorHandler(
      child: HtmlView(apiResponse.data),
      onRefresh: (){

      },
      errors: [apiResponse.error],
      statuses: [apiResponse.status],
    );
  }
}

class HtmlView extends StatelessWidget {
  HtmlModel htmlModel;

  HtmlView(this.htmlModel);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(16.toWidth),
      child: ListView(
        children: [
          SizedBox(
            height: 4.toHeight,
          ),
          HtmlWidget(
            htmlModel.header,
            textStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 14.toFont),
          ),
          SizedBox(
            height: 16.toHeight,
          ),
          Image.network(htmlModel.image),
          HtmlWidget(htmlModel.content),
        ],
      ),
      height: SizeConfig().screenHeight,
    );
  }
}
