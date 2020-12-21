import 'package:ari/business_logic/models/user.dart';

class ApiConfig {
  final String BASE_URl = 'http://bees.az/api/?action=';

  String FOOD_URl(String id) => '${BASE_URl}food&restourant_id=${id}&gr=1';

  String RESTOURANT_URl(String id, String lang) =>
      '${BASE_URl}mainpage&text=${id}';

  String MENU_URL(String id) => '${BASE_URl}menu&restourant_id=${id}';

  String SEARCH_URL(String query, String maxNum) =>
      '${BASE_URl}search&q=${query}&num=${maxNum}';

  String FETCH_MAP_ZONE() => BASE_URl + 'zone';

  String ADD_TO_BAG(String address, String coords, String jsonString,
          String restId, String token) =>
      '${BASE_URl}addtobag&token=${token}&address=${address}&coords=${coords}&jsonString=${jsonString}&restid=${restId}';

  String LOGIN_URL(User user) =>
      '${BASE_URl}login&username=${user.login}&password=${user.pass}&devicetoken=${user.device_token}';

  String REGISTER_URL(User user) =>
      '${BASE_URl}register&login=${user.login}&password=${user.pass}&name=${user.name}'
      '&surname=${user.surname}&number=${user.number}&rules=1&email=${user.email}';

  String STATUS(String token) => '${BASE_URl}status&token=${token}';

  String PROFILE_URL(String token) => '${BASE_URl}userpage&token=${token}';

  //get curyer price
  String GET_CURYER_PRICE(String token, String restId) =>
      '${BASE_URl}getcuryerprice&token=${token}&restid=${restId}';

  //html
  String HTML_URL(String url) =>
      'https://bees.az/api/?action=stat&lang=ru&page=${url}';
}
