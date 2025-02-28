import '../../../../core/utils/typedefs.dart';
import '../../data/data_sources/data_sources.dart';

import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/http_operation.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImp extends AuthRepository {
  final AuthRemoteDataSource _dataSource;

  AuthRepositoryImp(this._dataSource);

  @override
  FutureResponseModel login({String? phoneNumber, String? password}) {
    return _dataSource.login(phoneNumber, password);
  }

  @override
  FutureResponseModel signUp(
      {String? firstName,
      String? lastName,
      String? email,
      String? phoneNumber,
      String? password,
      String? generatedToken}) {
    return _dataSource.signUp(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        generatedToken: generatedToken);
  }

  @override
  FutureResponseModel checkIfDataValid(
      {String? firstName,
      String? lastName,
      String? email,
      String? phoneNumber,
      String? password}) {
    return _dataSource.checkIfDataValid(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        password: password);
  }

  @override
  FutureResponseModel sendOtp({String? phoneNumber}) {
    return _dataSource.sendOtp(phoneNumber: phoneNumber);
  }

  @override
  FutureResponseModel verifyOtp({String? phoneNumber, String? otp}) {
    return _dataSource.verifyOtp(
      phoneNumber: phoneNumber,
      otp: otp
    );
  }

  @override
  FutureResponseModel forgetPassword({String? phoneNumber, String? password}) {
    return _dataSource.forgetPassword(
      phoneNumber: phoneNumber,
      password: password
    );
  }

}
