import 'StateModel.dart';

class ResponseModel {
  ResponseState? responseState;
  int? code;
  String? message;
  List<String>? errors;
  dynamic data;

  ResponseModel({this.responseState = ResponseState.Initial,this.code ,this.message = "",this.data,this.errors});

  factory ResponseModel.fromJson(dynamic map) {
    return ResponseModel(
      code: map['code'] ?? 0,
      message : ( map['message'] != null &&  map['message'] is String) ? map['message'] as String : ( map['message'] != null &&  map['message'] is String) ? map['message'] as String : null,
      data : map['data'] ?? map,
      errors: map['errors'] is List
          ? (map['errors'] as List).map((e) => e.toString()).toList()
          : null,
    );
  }

  @override
  String toString() {
    return '{${this.code} , ${this.message} ${this.responseState}';
  }

  String? getFullError() {

    String err = errors?.map((errorValue) => errorValue).join("\n") ?? "$message";
    print("Full Er $err");
    return err;
  }
  StateModel toState(data){
    return StateModel(state: code == 200 ? DataState.SUCCESS : DataState.ERROR , message: message , data: data);
  }
}

enum ResponseState {
  Initial,
  Loading,
  Loaded,
  Error,
  Succuss
}