class ApiConfig {
  final String BASE_URl = 'http://numbersapi.com/random/trivia?json/';

  final String FOOD_URl =
      'http://bees.az/api/?action=food&lang=ru&restourant_id=9';

  String RESTOURANT_URl(String id) =>
      'http://bees.az/api/?action=restourants&lang=ru&text=${id}';
}
