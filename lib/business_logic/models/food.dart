class Food {
  String id;
  String name;
  String price;
  String information;
  String image;
  String menu_id;
  String restourant_id;
  List adds;

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    information = json['information'];
    image = json['image'];
    menu_id = json['menu_id'];
    restourant_id = json['restourant_id'];
  }

  @override
  String toString() {
    return 'Food{id: $id, name: $name, price: $price, information: $information, image: $image, menu_id: $menu_id, restourant_id: $restourant_id, adds: $adds}';
  }
}

List<Food> listFoodsFromJson(List<dynamic> foodlist) =>
    List<Food>.from(foodlist.map((e) => Food.fromJson(e)));
