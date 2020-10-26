import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/business_logic/models/search.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/services/search_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/views/home/widgets/restourant_item.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchViewModel extends HookWidget {
  @override
  Widget build(BuildContext context) {
    ApiResponse<Search> apiResponse = useSearchList('Беф', '10');
    print(apiResponse.data.results);

    // TODO: implement build
    return ErrorHandler(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4)),
                child: Center(
                  child: Text('Text'),
                )),
            SizedBox(
              height: 16.toHeight,
            ),
            Text('Найдено 28 ресторанов'),
            SizedBox(
              height: 16.toHeight,
            ),
            Container(
                height: 300.toHeight,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50.toHeight,
                      child: RestourantItem(
                          restourant: Restourant(
                              image: apiResponse.data.results[index].image,
                              name: apiResponse.data.results[index].name,
                              information:
                                  apiResponse.data.results[index].information)),
                    );
                  },
                  itemCount: apiResponse.data.results?.length,
                ))
          ],
        ),
        height: SizeConfig().screenHeight,
      ),
      status: apiResponse.status,
      error: apiResponse.error,
    );
  }
}
