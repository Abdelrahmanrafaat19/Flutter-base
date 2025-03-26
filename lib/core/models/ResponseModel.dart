import 'StateModel.dart';

class ResponseModel {
  ResponseState? responseState;
  int? code;
  String? message;
  List<String>? errors;
  dynamic data;
  PaginationModel? pagination;

  ResponseModel({
    this.responseState = ResponseState.Initial,
    this.code,
    this.message = "",
    this.data,
    this.errors,
    this.pagination,
  });

  factory ResponseModel.fromJson(dynamic map) {
    return ResponseModel(
      code: map['code'] ?? 0,
      message: (map['message'] != null && map['message'] is String)
          ? map['message'] as String
          : (map['message'] != null && map['message'] is String)
              ? map['message'] as String
              : null,
      data: map['data'] ?? map,
      errors: map['errors'] is List
          ? (map['errors'] as List).map((e) => e.toString()).toList()
          : null,
      pagination: map['pagination'] != null
          ? PaginationModel.fromJson(map['pagination'])
          : null,
    );
  }

  @override
  String toString() {
    return '{${this.code} , ${this.message} ${this.responseState} ${this.pagination}}';
  }

  String? getFullError() {
    String err =
        errors?.map((errorValue) => errorValue).join("\n") ?? "$message";
    print("Full Er $err");
    return err;
  }

  StateModel toState(data) {
    return StateModel(
        state: code == 200 ? DataState.SUCCESS : DataState.ERROR,
        message: message,
        data: data);
  }
}

class PaginationModel {
  int? currentPage;
  int? from;
  int? to;
  int? total;
  int? lastPage;

  PaginationModel({
    this.currentPage = 1,
    this.from = 1,
    this.to = 0,
    this.total = 0,
    this.lastPage = 0,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['currentPage'] ?? 1,
      from: json['from'] ?? 1,
      to: json['to'] ?? 0,
      total: json['total'] ?? 0,
      lastPage: json['lastPage'] ?? 0,
    );
  }

  @override
  String toString() {
    return '{currentPage: $currentPage, from: $from, to: $to, total: $total, lastPage: $lastPage}';
  }
}

enum ResponseState { Initial, Loading, Loaded, Error, Succuss }
