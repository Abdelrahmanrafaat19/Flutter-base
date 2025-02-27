import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnableButtonActionStateNotifier extends StateNotifier<bool>{
  EnableButtonActionStateNotifier() : super(false);

  void updateStatue(bool newState) async {
    state = newState;
  }
}

final otpProvider = StateNotifierProvider<EnableButtonActionStateNotifier, bool>((ref) {
  return EnableButtonActionStateNotifier();
});

final enableLoginProvider = StateNotifierProvider<EnableButtonActionStateNotifier, bool>((ref) {
  return EnableButtonActionStateNotifier();
});


final forgetPasswordProvider = StateNotifierProvider<EnableButtonActionStateNotifier, bool>((ref) {
  return EnableButtonActionStateNotifier();
});

final changePasswordProvider = StateNotifierProvider<EnableButtonActionStateNotifier, bool>((ref) {
  return EnableButtonActionStateNotifier();
});
