import 'package:ari/business_logic/models/status.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/services/status_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari/utils/size_config.dart';

class StatusViewModel extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //get user status
    ApiResponse<StatusModel> apiResponse = useStatus();
    useEffect((){
      print('API REAPONSE ${apiResponse.error}');
      return (){

      };
    },[apiResponse]);

    //dragable widget offset
    var offset = useState<Offset>(Offset.zero);

    return SpUtil.getString(SpUtil.token).isNotEmpty
        ? CustomErrorHandler(
            errors: [apiResponse.error],
            statuses: [apiResponse.status],
            child: Positioned(
                left: offset.value.dx + 10,
                top: offset.value.dy + 100,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    offset.value = Offset(offset.value.dx + details.delta.dx,
                        offset.value.dy + details.delta.dy);
                  },
//                  child: Card(
//                      elevation: 4,
//                      shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(60)),
//                      child: Container(
//                          width: 70.toWidth,
//                          height: 70.toWidth,
//                          decoration: new BoxDecoration(
//                              shape: BoxShape.circle,
//                              border: Border.all(
//                                  color: ThemeColor().yellowColor,
//                                  width: 2.toHeight),
//                              image: new DecorationImage(
//                                  fit: BoxFit.fill,
//                                  image: new NetworkImage(apiResponse
//                                      .data.order[0].restourant.image))))),
                )))
        : SizedBox();
  }
}
