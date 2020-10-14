import 'dart:io';
import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ApiBaseHelper {
  Dio dio = useMemoized(() => Dio());

  Future<Response> get(String url) async {
    var responseJson;
    try {
      final response = await dio.get(url);
      responseJson = response;
    } on SocketException {
      throw FetchDataException('No internet connection');
    }
    return responseJson;
  }
//  _returnResponse(Response response) {
//    print('Status code ${response.statusCode}');
//    print('Status code ${response.body}');
//    switch (response.statusCode) {
//
//      case 200:
//        var responseJson = convert.jsonDecode(response.body);
//        print(responseJson);
//        return responseJson;
//      case 400:
//        throw BadRequestException(convert.jsonDecode(response.body));
//      case 403:
//        throw UnauthorisedException(convert.jsonDecode(response.body));
//      default:
//        throw FetchDataException('Error Occured');
//    }
//  }
}

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}
