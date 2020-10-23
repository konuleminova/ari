import 'package:ari/business_logic/models/food.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/ui/common_widgets/loading.dart';
import 'package:ari/ui/views/restaurant/widgets/food_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ari/utils/size_config.dart';

class RestaurantView extends StatelessWidget {
  ApiResponse<List<Food>> apiResponse;

  RestaurantView({this.apiResponse});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Stack(
                children: <Widget>[
                  ClipRRect(
                    child: Image.network(
                      'https://bees.az/___entcpanel/uploads/d3271c371aae25d4f8c747912391ce93_206431.png',
                      width: SizeConfig().screenWidth,
                      height: SizeConfig().screenHeight,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(20)),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text('Some text'),
                                SizedBox(
                                  height: 4.toHeight,
                                ),
                                Text('info some')
                              ],
                            ),
                            Icon(
                              Icons.favorite_border,
                              size: 30,
                              color: Colors.white.withOpacity(0.6),
                            )
                          ],
                        ),
                        padding: EdgeInsets.all(8.toWidth),
                      ))
                ],
              )),
          Container(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 40.toHeight,
                    width: 40.toHeight,
                    padding: EdgeInsets.all(8.toWidth),
                    child: Text('Soap'),
                    margin: EdgeInsets.symmetric(horizontal: 8.toWidth),
                  );
                },
                itemCount: 10,
                scrollDirection: Axis.horizontal,
              ),
              width: SizeConfig().screenWidth,
              height: 25.toHeight),
          Divider(
            color: Colors.grey.withOpacity(0.1),
          ),
          Expanded(
            flex: 3,
            child: apiResponse?.status == Status.Error
                ? Center(
                    child: Text(apiResponse.error.message),
                  )
                : apiResponse?.status == Status.Loading
                    ? Loading()
                    : ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return FoodItem(item: apiResponse.data[index]);
                        },
                        itemCount: apiResponse.data.length,
                      ),
          )
        ],
      ),
    );
  }
}
