import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/restourant.dart';

class Search extends Restourant {
  //Search.fromJson(Map<String, dynamic> json) : super.fromJson(json);
  int found;
  String type;
  List<dynamic> results;

  Search.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    found = json['found'];
    type = json['type'];
    results = type == 'food'
        ? listFoodsFromJson(json['results'])
        : resourantListFromJson(json['results']);
  }

  @override
  String toString() {
    return 'Search{found: $found, type: $type, results: $results}';
  }
}
