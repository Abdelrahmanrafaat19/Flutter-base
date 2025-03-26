import '../../../../core/models/ResponseModel.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/http_operation.dart';
import '../../../../core/utils/typedefs.dart';

class AuthRemoteDataSource {
  final HttpOperations _httpOps;

  AuthRemoteDataSource(this._httpOps);

  FutureResponseModel login(String? phoneNumber, String? password) {
    return _httpOps.postData(
      authorized: false,
      endPoint: userLoginEndPoint,
      data: {
        "phoneNumber": phoneNumber.toString(),
        "password": password.toString(),
      },
    );
  }

  FutureResponseModel signUp(
      {String? firstName,
      String? lastName,
      String? email,
      String? phoneNumber,
      String? password,
      String? generatedToken}) {
    return _httpOps.postData(
      authorized: false,
      endPoint: userRegisterEndPoint,
      data: {
        "firstName": firstName.toString(),
        "lastName": lastName.toString(),
        "email": email.toString(),
        "phoneNumber": phoneNumber.toString(),
        "password": password.toString(),
        "generatedToken": generatedToken.toString(),
      },
    );
  }

  FutureResponseModel checkIfDataValid(
      {String? firstName,
      String? lastName,
      String? email,
      String? phoneNumber,
      String? password}) {
    return _httpOps.postData(
      authorized: false,
      endPoint: userCheckValidityEndPoint,
      data: {
        "firstName": firstName.toString(),
        "lastName": lastName.toString(),
        "email": email.toString(),
        "phoneNumber": phoneNumber.toString(),
        "password": password.toString()
      },
    );
  }

  FutureResponseModel sendOtp({
    String? phoneNumber,
    bool? checkExistence ,
  }) {
    return _httpOps.postData(
      authorized: false,
      endPoint: sendOtpEndPoint,
      params: "?checkExistence=$checkExistence",
      data: {"phoneNumber": phoneNumber.toString()},
    );
  }

  FutureResponseModel verifyOtp({String? phoneNumber, String? otp}) {
    return _httpOps.postData(
      authorized: false,
      endPoint: verifyOtpEndPoint,
      data: {"phoneNumber": phoneNumber.toString(), "otp": otp.toString()},
    );
  }

  FutureResponseModel forgetPassword({String? phoneNumber, String? password}) {
    return _httpOps.putData(
      authorized: false,
      endPoint: usersEndPoint,
      params: "$phoneNumber/password",
      data: {"password": password.toString()},
    );
  }
}
