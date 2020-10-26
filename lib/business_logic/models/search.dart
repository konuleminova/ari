import 'package:ari/business_logic/models/food.dart';
import 'package:ari/business_logic/models/restourant.dart';

class Search extends Restourant {
  //Search.fromJson(Map<String, dynamic> json) : super.fromJson(json);
  int found;
  String type;
  List<Food> results;

  Search.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    found = json['found'];
    type = json['type'];
    results = listFoodsFromJson(json['results']);
  }

  @override
  String toString() {
    return 'Search{found: $found, type: $type, results: $results}';
  }
}
