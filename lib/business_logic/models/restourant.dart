class RestourantList {
  String text;
  List<Restourant> results;

  RestourantList.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    results = resourantListFromJson(json['results']);
  }
}

class Restourant {
  String id;
  String name;
  String sm_name;
  String information;
  String image;
  String priceRange;
  String coords;
  String working_time;
  String delivery_time;
  String categories;

  Restourant(
      {this.id,
      this.name,
      this.sm_name,
      this.information,
      this.image,
      this.priceRange,
      this.coords,
      this.working_time,
      this.delivery_time,
      this.categories});

  Restourant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sm_name = json['sm_name'];
    information = json['information'];
    image = json['image'];
    priceRange = json['priceRange'];
    coords = json['coords'];
    working_time = json['working_time'];
    delivery_time = json['delivery_time'];
    categories = json['categories'];
  }

  @override
  String toString() {
    return 'Restourant{id: $id, name: $name, sm_name: $sm_name, information: $information, image: $image, priceRange: $priceRange, coords: $coords, working_time: $working_time, delivery_time: $delivery_time, categories: $categories}';
  }
}

List<Restourant> resourantListFromJson(List<dynamic> restourantList) =>
    (List<Restourant>.from(restourantList.map((e) => Restourant.fromJson(e))));
