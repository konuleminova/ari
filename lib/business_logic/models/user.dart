class User {
  String id;
  String name;
  String login;
  String mobile;
  String coords;
  String email;
  String image;
  String token;
  String device_token;
  String pass;
  String surname;
  String number;

  User(
      {this.name,
      this.login,
      this.email,
      this.device_token,
      this.pass,
      this.surname,
      this.number});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    login = json['login'];
    mobile = json['mobile'];
    coords = json['coords'];
    email = json['email'];
    image = json['image'];
    token = json['token'];
    device_token = json['device_token'];
  }
}
