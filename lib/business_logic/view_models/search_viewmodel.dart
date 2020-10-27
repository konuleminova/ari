import 'package:ari/business_logic/models/restourant.dart';
import 'package:ari/business_logic/models/search.dart';
import 'package:ari/services/api_helper/api_response.dart';
import 'package:ari/services/services/search_service.dart';
import 'package:ari/ui/common_widgets/error_handler.dart';
import 'package:ari/ui/views/home/widgets/restourant_item.dart';
import 'package:ari/ui/views/search/search.dart';
import 'package:ari/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchViewModel extends HookWidget {
  @override
  Widget build(BuildContext context) {
    ApiResponse<Search> apiResponse = useSearchList('a', '10');
    useEffect(() {
      return () {};
    }, [apiResponse]);
    // print(apiResponse.data.results);

    // TODO: implement build
    return CustomErrorHandler(
      child: SearchView(
        search: apiResponse.data,
      ),
      statuses: [apiResponse.status],
      errors: [apiResponse.error],
    );
  }
}
