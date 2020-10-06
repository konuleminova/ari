import 'package:dio/dio.dart';

class ApiResponse<T> {
  T data;
  Status status;
  DioError error;

  ApiResponse({this.data, this.status, this.error});

//  ApiResponse.initial() : status = Status.Idle;
//  ApiResponse.loading() : status = Status.Loading;
//
//  ApiResponse.completed(this.data) : status = Status.Done;
//
//  ApiResponse.error(this.error) : status = Status.Error;
  factory ApiResponse.initial() {
    return new ApiResponse(status: Status.Idle, data: null, error: null);
  }

  factory ApiResponse.completed(T data) {
    return new ApiResponse(status: Status.Done, data: data, error: null);
  }

  factory ApiResponse.loading() {
    return new ApiResponse(status: Status.Loading, data: null, error: null);
  }

  ApiResponse<V> copyWithData<V>(V Function(T) mapper) {
    return new ApiResponse<V>(
        status: this.status,
        error: this.error,
        data: this.data != null ? mapper(data) : null);
  }

  @override
  String toString() {
    return 'ApiResponse{data: $data, status: $status, error: $error}';
  }
}

enum Status { Loading, Done, Error, Idle }
