import 'package:ari/business_logic/models/status.dart';
import 'package:ari/business_logic/routes/route_navigation.dart';
import 'package:ari/localization/app_localization.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/utils/sharedpref_util.dart';
import 'package:ari/utils/size_config.dart';
import 'package:ari/utils/theme_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  ApiResponse<dynamic> apiResponse;

  ProfileView({this.apiResponse});

  StatusModel order;

  @override
  Widget build(BuildContext context) {
    if (apiResponse.data is StatusModel) {
      order = apiResponse.data;
    }

    // TODO: implement build
    return Container(
        height: SizeConfig().screenHeight,
        child: apiResponse.data is StatusModel && order.found > 0
            ? ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(context),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.toWidth, vertical: 4.toHeight),
                    child: Text(
                      AppLocalizations.of(context).translate('My Address') ??
                          'My Address',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: ThemeColor().grey1,
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(16.toWidth),
                    margin: EdgeInsets.all(16.toWidth),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: order.order.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(order.order[index].address ?? '',overflow: TextOverflow.ellipsis,),
                              SizedBox(
                                height: 4.toHeight,
                              ),
                              Divider(
                                color: Colors.grey,
                              )
                            ],
                          );
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.toWidth, vertical: 4.toHeight),
                    child: Text(
                      AppLocalizations.of(context).translate('My Orders') ??
                          'My Orders',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        shrinkWrap: true,
                        itemCount: order.order.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: 16.toWidth),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: ThemeColor().grey1))),
                              child: ExpansionTile(
                                childrenPadding: EdgeInsets.all(0),
                                backgroundColor:
                                    ThemeColor().yellowColor.withOpacity(0.4),
                                tilePadding:
                                    EdgeInsets.symmetric(horizontal: 4.toWidth),
                                trailing: Container(
                                    width: 40.toWidth,
                                    height: 40.toWidth,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: new NetworkImage(order
                                                .order[index]
                                                .restourant
                                                .image)))),
                                title: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16.toWidth),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 0.toWidth),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    order.order[index].restourant.name ?? '',
                                    style: TextStyle(fontSize: 14.toFont),
                                  ),
                                ),
                                children: [
                                  ListView.builder(
                                    itemBuilder: (BuildContext context, int i) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${order.order[index].foods[i].apiCount} ${order.order[index].foods[i].name}',
                                            style:
                                                TextStyle(fontSize: 14.toFont),
                                          ),
                                          SizedBox(
                                            height: 4.toHeight,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16.toWidth),
                                            child: order.order[index].foods[i]
                                                        .adds.length >
                                                    0
                                                ? ListView.builder(
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int j) {
                                                      return Text(
                                                        '${order.order[index].foods[i].adds[j].count} '
                                                        ' ${order.order[index].foods[i].adds[j].name} ',
                                                        style: TextStyle(
                                                            fontSize: 12.toFont,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      );
                                                    },
                                                    itemCount: order
                                                        .order[index]
                                                        .foods[i]
                                                        .adds
                                                        .length,
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                  )
                                                : SizedBox(),
                                          ),
                                          SizedBox(
                                            height: 2.toHeight,
                                          ),
                                        ],
                                      );
                                    },
                                    itemCount: order.order[index].foods.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(16.toWidth),
                                    physics: NeverScrollableScrollPhysics(),
                                  ),
                                  Container(
                                    child: Text(
                                      '${order.order[index].final_price} ???',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.toFont),
                                    ),
                                    width: SizeConfig().screenWidth,
                                    alignment: Alignment.bottomRight,
                                    margin: EdgeInsets.all(16.toWidth),
                                  )
                                ],
                              ));
                        }),
                  )
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _header(context),
                  Expanded(
                    child: Center(
                      child: Text(
                        apiResponse.data.message ?? '',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ));
  }

  _header(BuildContext context) => Container(
        padding: EdgeInsets.all(16.toWidth),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              SpUtil.getString(SpUtil.name),
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8.toWidth),
                decoration: BoxDecoration(
                    color: ThemeColor().greenLightColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(AppLocalizations.of(context)
                        .translate('logoutButtonText') ??
                    'Logout'),
                width: 90.toWidth,
                height: 28.toHeight,
              ),
              onTap: () {
                SpUtil.remove(SpUtil.token);
                SpUtil.remove(SpUtil.address);
                SpUtil.remove(SpUtil.lat);
                SpUtil.remove(SpUtil.lng);
                pushReplaceRouteWithName('/');
              },
            )
          ],
        ),
      );
}
