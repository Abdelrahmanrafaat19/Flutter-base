import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/ResponseModel.dart';
import '../../../../core/models/StateModel.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class CheckIfDataValidUseCase extends StateNotifier<StateModel<bool>>{
  final Ref ref;
  final AuthRepository _authRepository;
  CheckIfDataValidUseCase(this.ref, this._authRepository):super(StateModel());

  void call({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? password
  }) async{

    state = StateModel.loading();

    ResponseModel responseModel = await _authRepository.checkIfDataValid(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        password: password
    );

    if(responseModel.code == 200){
      state = StateModel(
          state: DataState.SUCCESS,
          data: true,
          message: responseModel.message
      );
    }else {
      state = StateModel(
          state: DataState.ERROR,
          message: responseModel.message,
          errors: responseModel.errors);
    }
  }
}