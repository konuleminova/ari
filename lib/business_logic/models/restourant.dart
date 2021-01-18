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
  String sticker;
  String sticker_st_color;
  String sticker_en_color;
  String sticker_text;
  String percent;
  String minprice;

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
      this.working = true,
      this.sticker,
      this.sticker_st_color,
      this.sticker_en_color,
      this.percent,
      this.minprice});

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
    working = json['working'] == null ? true : json['working'];
    sticker = json['sticker'];
    sticker_st_color = json['sticker_st_color'];
    sticker_en_color = json['sticker_en_color'];
    percent = json['percent'];
    minprice = json['minprice'];
  }

  @override
  String toString() {
    return 'Restourant{id: $id, name: $name, sm_name: $sm_name, information: $information, image: $image, priceRange: $priceRange, coords: $coords, working_time: $working_time, delivery_time: $delivery_time, categories: $categories}';
  }
}

List<Restourant> resourantListFromJson(List<dynamic> restourantList) =>
    (List<Restourant>.from(restourantList.map((e) => Restourant.fromJson(e))));
