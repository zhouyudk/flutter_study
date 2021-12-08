import 'package:dio/dio.dart';

class Resource<T>{
  final T? data;
  final DioError? e;
  final Status status;
  Resource.success({required this.data, this.e, this.status = Status.success});

  Resource.empty({this.data, this.e, this.status = Status.empty});

  Resource.error({this.data, required this.e, this.status = Status.error});

  Resource.loading({this.data, this.e, this.status = Status.loading});
}

enum Status {
 empty, loading, success, error
}