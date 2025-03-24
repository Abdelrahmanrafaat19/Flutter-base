import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/ResponseModel.dart';
import '../../../../core/models/StateModel.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class SendOtpUseCase extends StateNotifier<StateModel<dynamic>> {
  final Ref ref;
  final AuthRepository _authRepository;

  SendOtpUseCase(this.ref, this._authRepository) : super(StateModel());

  void call({String? phoneNumber, bool? checkExistence = false}) async {
    state = StateModel.loading();

    ResponseModel responseModel = await _authRepository.sendOtp(
      phoneNumber: phoneNumber,
      checkExistence: checkExistence,
    );

    if (responseModel.code == 200) {
      state = StateModel(
          state: DataState.SUCCESS, data: true, message: responseModel.message);
    } else {
      state = StateModel(
          state: DataState.ERROR,
          message: responseModel.message,
          errors: responseModel.errors);
    }
  }
}
