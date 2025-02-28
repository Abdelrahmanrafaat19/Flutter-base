import 'package:flutter_base/features/auth/domain/use_cases/signup_usecase.dart';

import '../../../../core/models/StateModel.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/providers/auth_repository_provider.dart';
import '../../domain/use_cases/check_If_data_valid_usecase.dart';
import '../../domain/use_cases/login_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_cases/send_otp_usecase.dart';
import '../../domain/use_cases/verify_otp_usecase.dart';

final loginStateNotifierProvider =
    StateNotifierProvider.autoDispose<LoginUseCase, StateModel<User>>(
        (ref) => LoginUseCase(ref, ref.read(authRepoProvider)));

final signUpStateNotifierProvider =
    StateNotifierProvider.autoDispose<SignupUseCase, StateModel<User>>(
        (ref) => SignupUseCase(ref, ref.read(authRepoProvider)));

final checkIfDataValidStateNotifierProvider =
    StateNotifierProvider.autoDispose<CheckIfDataValidUseCase, StateModel<bool>>(
        (ref) => CheckIfDataValidUseCase(ref, ref.read(authRepoProvider)));

final sendOtpStateNotifierProvider =
    StateNotifierProvider.autoDispose<SendOtpUseCase, StateModel<dynamic>>(
        (ref) => SendOtpUseCase(ref, ref.read(authRepoProvider)));

final verifyOtpStateNotifierProvider =
    StateNotifierProvider.autoDispose<VerifyOtpUseCase, StateModel<dynamic>>(
        (ref) => VerifyOtpUseCase(ref, ref.read(authRepoProvider)));
