import '../../../../core/models/ResponseModel.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/http_operation.dart';

class AuthRemoteDataSource {
  final HttpOperations _httpOps;

  AuthRemoteDataSource(this._httpOps);

  Future<ResponseModel> login(String? phoneNumber, String? password) {
    return _httpOps.postData(
      endPoint: userLoginEndPoint,
      data: {
        "phoneNumber": phoneNumber.toString(),
        "password": password.toString(),
      },
    );
  }

  Future<ResponseModel> signUp(
      {String? firstName,
        String? lastName,
        String? email,
        String? phoneNumber,
        String? password,
        String? generatedToken})  {
    return _httpOps.postFormData(
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
}
