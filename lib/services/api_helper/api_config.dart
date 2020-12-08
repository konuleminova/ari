import 'package:ari/business_logic/models/user.dart';

class ApiConfig {
  final String BASE_URl = 'http://bees.az/api/?action=';

  String FOOD_URl(String id) =>
      '${BASE_URl}food&lang=ru&restourant_id=${id}&gr=1';

  String RESTOURANT_URl(String id) =>
      '${BASE_URl}restourants&lang=ru&text=${id}';

  String MENU_URL(String id) => '${BASE_URl}menu&lang=ru&restourant_id=${id}';

  String SEARCH_URL(String query, String maxNum) =>
      '${BASE_URl}search&lang=ru&q=${query}&num=${maxNum}';

  String FETCH_MAP_ZONE() => BASE_URl + 'zone&lang=ru';

  String ADD_TO_BAG(String address, String coords, String jsonString,
          String restId, String token) =>
      '${BASE_URl}addtobag&&lang=ru&token=${token}&address=${address}&coords=${coords}&jsonString=${jsonString}&restid=${restId}';

  String LOGIN_URL(User user) =>
      '${BASE_URl}login&username=${user.login}&password=${user.pass}&lang=ru&devicetoken=${user.device_token}';

  String REGISTER_URL(User user) =>
      '${BASE_URl}register&lang=ru&login=${user.login}&password=${user.pass}&name=${user.name}'
      '&surname=${user.surname}&number=${user.number}&rules=1&email=${user.email}';

  String STATUS(String token) => '${BASE_URl}status&token=${token}&lang=ru';
}
