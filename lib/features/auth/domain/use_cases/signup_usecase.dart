
import 'package:flutter_base/core/models/ResponseModel.dart';
import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_base/features/auth/data/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/user_entity.dart';
import '../providers/user_provider.dart';
import '../repositories/auth_repository.dart';

class SignupUseCase extends StateNotifier<StateModel<User>>{
  final Ref ref;
  final AuthRepository _authRepository;
  SignupUseCase(this.ref, this._authRepository):super(StateModel());

  void call({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? password,
    String? generatedToken,
  }) async{

    state = StateModel.loading();

    ResponseModel responseModel = await _authRepository.signUp(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        generatedToken: generatedToken
    );

    if (responseModel.code == 200) {
      var user = UserModel.fromJson(responseModel.data);

      // save user data
      ref.read(userProvider.notifier).setUser(user);

      state = StateModel(
          state: DataState.SUCCESS,
          data: toUserEntity(user),
          message: responseModel.message);
    } else {
      state = StateModel(
          state: DataState.ERROR,
          message: responseModel.message,
          errors: responseModel.errors);
    }
  }
}