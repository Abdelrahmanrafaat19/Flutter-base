
import 'package:flutter_base/core/models/ResponseModel.dart';
import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_base/features/auth/data/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/user_entity.dart';
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

    ResponseModel signUpResponse = await _authRepository.signUp(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        generatedToken: generatedToken
    );

    if(signUpResponse.code == true){
      state = StateModel(
        state: DataState.SUCCESS,
        data: toUserEntity(UserModel.fromJson(signUpResponse.data)),
        message: signUpResponse.message
      );
    }
  }
}