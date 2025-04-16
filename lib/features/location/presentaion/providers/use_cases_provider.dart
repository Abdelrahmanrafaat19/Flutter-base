import 'package:flutter_base/features/permissions/data/model/address_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_cases/user_location_usecase.dart';

final updateUserLocationStateNotifierProvider =
    StateNotifierProvider<UserLocationUseCase, Address?>(
        (ref) => UserLocationUseCase());
