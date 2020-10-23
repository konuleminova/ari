class ApiConfig {
  final String BASE_URl = 'http://numbersapi.com/random/trivia?json/';

  String FOOD_URl(String id) =>
      'http://bees.az/api/?action=food&lang=ru&restourant_id=${id}';

  String RESTOURANT_URl(String id) =>
      'http://bees.az/api/?action=restourants&lang=ru&text=${id}';
}
