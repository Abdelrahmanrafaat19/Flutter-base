
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ValidationStateNotifier extends StateNotifier<Map<String,String>>{
  ValidationStateNotifier() : super({});

  void updateStatue(Map<String,String> newState) async {
    state = newState;
  }
}


final validationLoginProvider = StateNotifierProvider<ValidationStateNotifier, Map<String,String>>((ref) {
  return ValidationStateNotifier();
});

final validationSignUpProvider = StateNotifierProvider<ValidationStateNotifier, Map<String,String>>((ref) {
  return ValidationStateNotifier();
});