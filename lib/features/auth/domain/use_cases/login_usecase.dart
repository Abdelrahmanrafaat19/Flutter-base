import '../../data/models/user_model.dart';
import '../../domain/entities/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/ResponseModel.dart';
import '../../../../core/models/StateModel.dart';
import '../providers/user_provider.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase extends StateNotifier<StateModel<User>> {
  final Ref ref;
  final AuthRepository _authRepository;
  LoginUseCase(this.ref, this._authRepository) : super(StateModel());

  void call({String? phoneNumber, String? password}) async {
    state = StateModel(state: DataState.LOADING);

    ResponseModel responseModel = await _authRepository.login(
        phoneNumber: phoneNumber, password: password
    );

    if (responseModel.code == 200) {
      var user = UserModel.fromJson(responseModel.data);
      print("this is Loged User $user");

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
