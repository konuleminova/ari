class PaymentResponse {
  String message;
  String string;
  String urltogo;

  PaymentResponse.fromJsom(Map<String, dynamic> json) {
    message = json['message'];
    string = json['string'];
    urltogo = json['urltogo'];
  }

}
