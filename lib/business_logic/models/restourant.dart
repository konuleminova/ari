class RestourantList {
  String text;
  String message;
  List<Restourant> results;
  List<Restourant> adv;
  String our_partners;

  RestourantList.fromJson(Map<String, dynamic> json) {
    text = json['text'] ?? '';
    message = json['message_text'] ?? '';
    results =
        json['results'] != null ? resourantListFromJson(json['results']) : [];
    adv = json['adv'] != null ? resourantListFromJson(json['adv']) : [];
    our_partners = json['our_partners'] ?? '';
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
  bool working;

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
      this.categories,
      this.working});

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
    working = json['working'] ?? false;
  }

  @override
  String toString() {
    return 'Restourant{id: $id, name: $name, sm_name: $sm_name, information: $information, image: $image, priceRange: $priceRange, coords: $coords, working_time: $working_time, delivery_time: $delivery_time, categories: $categories}';
  }
}

List<Restourant> resourantListFromJson(List<dynamic> restourantList) =>
    (List<Restourant>.from(restourantList.map((e) => Restourant.fromJson(e))));
