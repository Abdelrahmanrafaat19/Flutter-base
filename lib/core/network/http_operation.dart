import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'dart:developer' as developer;
import '../Localization/AppLocalizations.dart';
import '../models/ResponseModel.dart';
import 'api_endpoints.dart';

class HttpOperations {
  final Ref ref;
  String? userToken;

  HttpWithMiddleware httpLog = HttpWithMiddleware.build(middlewares: [
    HttpLogger(logLevel: LogLevel.BODY),
  ]);

  HttpOperations(this.ref);

  Future<ResponseModel> postData(
      {required String endPoint,
      bool authorized = false,
      Map? data,
      String params = ""}) async {
    try {
      final response = await httpLog.post(
        Uri.parse(mainAppUrl + endPoint + (params)),
        headers: authorized
            ? <String, String>{
                'Authorization': 'Bearer $userToken',
                'Content-Type': 'application/json',
                'accept': 'application/hal+json',
                'lang': AppLocalizations.globalLocale?.languageCode ?? "en"
              }
            : {
                'Content-Type': 'application/json',
                'accept': 'application/hal+json',
                'lang': AppLocalizations.globalLocale?.languageCode ?? "en"
              },
        body: json.encode(data ?? {}),
      );

      developer.log(
        '${response.request}',
        name: 'Request',
      );

      developer.log(
        '$data',
        name: 'RequestBody',
      );
      developer.log(
        _getPrettyJSONString(json.decode(response.body)),
        name: 'Response',
      );

      print("responseModel code: ${response.statusCode}");

      if (response.statusCode == 200) {
        return ResponseModel.fromJson(jsonDecode(response.body));
      } else {
        return ResponseModel(
            responseState: ResponseState.Error,
            code: response.statusCode,
            message: jsonDecode(response.body)['message'] ??
                'Unexpected error occurred',
            errors: jsonDecode(response.body)['errors']);
      }
    } catch (e) {
      print(e);
      developer.log(
        e.toString(),
        name: 'Err',
      );

      return ResponseModel(
          responseState: ResponseState.Error, code: 500, message: e.toString());
    }
  }

  Future<ResponseModel> getData(
      {required String endPoint,
      bool authorized = false,
      String params = ""}) async {
    try {
      final response = await httpLog.get(
        Uri.parse(mainAppUrl + endPoint + (params)),
        headers: authorized
            ? <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $userToken',
                "Accept": "application/json",
                'lang': AppLocalizations.globalLocale?.languageCode ?? "en"
              }
            : {
                'Content-Type': 'application/json; charset=UTF-8',
                "Accept": "application/json",
                'lang': AppLocalizations.globalLocale?.languageCode ?? "en"
              },
      );
      developer.log(
        '${response.request}',
        name: 'Request',
      );
      developer.log(
        _getPrettyJSONString(json.decode(response.body)),
        name: 'Response',
      );
      if (response.statusCode == 200) {
        return ResponseModel.fromJson(jsonDecode(response.body));
      } else {
        return ResponseModel(
            responseState: ResponseState.Error,
            code: response.statusCode,
            message: jsonDecode(response.body)['message'] ??
                'Unexpected error occurred',
            errors: jsonDecode(response.body)['errors']);
      }
    } catch (e) {
      print("HTTP Error $e");

      return ResponseModel(
          responseState: ResponseState.Error, code: 500, message: e.toString());
    }
  }

  Future<ResponseModel> deleteData(
      {required String endPoint,
      bool authorized = false,
      String params = ""}) async {
    try {
      final response = await httpLog.delete(
        Uri.parse(mainAppUrl + endPoint + (params)),
        headers: authorized
            ? <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $userToken',
                "Accept": "application/json",
                'lang': AppLocalizations.globalLocale?.languageCode ?? "en"
              }
            : {
                'Content-Type': 'application/json; charset=UTF-8',
                "Accept": "application/json",
                'lang': AppLocalizations.globalLocale?.languageCode ?? "en"
              },
      );
      developer.log(
        '${response.request}',
        name: 'Request',
      );
      developer.log(
        _getPrettyJSONString(json.decode(response.body)),
        name: 'Response',
      );
      if (response.statusCode == 200) {
        return ResponseModel.fromJson(jsonDecode(response.body));
      } else {
        return ResponseModel(
            responseState: ResponseState.Error,
            code: response.statusCode,
            message: jsonDecode(response.body)['message'] ??
                'Unexpected error occurred',
            errors: jsonDecode(response.body)['errors']);
      }
    } catch (e) {
      print("HTTP Error $e");

      return ResponseModel(
          responseState: ResponseState.Error, code: 500, message: e.toString());
    }
  }

  Future<ResponseModel> postFormData(
      {required String endPoint,
      bool authorized = false,
      required Map<String, String> data,
      List<http.MultipartFile>? files,
      String params = ""}) async {
    try {
      var postUri = Uri.parse(mainAppUrl + endPoint + params);
      http.MultipartRequest request = http.MultipartRequest("POST", postUri);
      print("User Token $userToken");
      request.headers.addAll(
        authorized
            ? <String, String>{
                'Authorization': 'Bearer $userToken',
                'Content-Type': 'application/json;',
                'accept': 'application/hal+json',
                'lang': AppLocalizations.globalLocale?.languageCode ?? "en"
              }
            : {
                'Content-Type': 'application/json;',
                'accept': 'application/hal+json',
                'lang': AppLocalizations.globalLocale?.languageCode ?? "en"
              },
      );

      request.fields.addAll(data);

      if (files != null) request.files.addAll(files);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      developer.log(
        '${response.request}',
        name: 'Request',
      );

      developer.log(
        '${request.fields} , ${request.files}',
        name: 'RequestBody',
      );

      print(response.statusCode);
      developer.log(
        '${response.request}',
        name: 'Request',
      );
      developer.log(
        _getPrettyJSONString(json.decode(response.body)),
        name: 'Response',
      );

      if (response.statusCode == 200) {
        developer.log(_getPrettyJSONString(jsonDecode(response.body)),
            name: 'Response');
        return ResponseModel.fromJson(jsonDecode(response.body));
      } else {
        return ResponseModel(
            responseState: ResponseState.Error,
            code: response.statusCode,
            message: jsonDecode(response.body)['message'] ??
                'Unexpected error occurred',
            errors: jsonDecode(response.body)['errors']);
      }
    } catch (e) {
      print(e);
      developer.log(
        e.toString(),
        name: 'Err',
      );
      return ResponseModel(
          responseState: ResponseState.Error, code: 500, message: e.toString());
    }
  }

  static String _getPrettyJSONString(jsonObject) {
    var encoder = const JsonEncoder.withIndent("     ");
    return encoder.convert(jsonObject);
  }
}
