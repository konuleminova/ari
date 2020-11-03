class ApiConfig {
  final String BASE_URl = 'http://bees.az/api/?action=';

  String FOOD_URl(String id) => '${BASE_URl}food&lang=ru&restourant_id=${id}';

  String RESTOURANT_URl(String id) =>
      '${BASE_URl}restourants&lang=ru&text=${id}';

  String MENU_URL(String id) => '${BASE_URl}menu&lang=ru&restourant_id=${id}';

  String SEARCH_URL(String query, String maxNum) =>
      '${BASE_URl}search&lang=ru&q=${query}&num=${maxNum}';
}
