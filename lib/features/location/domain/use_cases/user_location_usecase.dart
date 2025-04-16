

import 'package:flutter_base/features/permissions/data/model/address_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserLocationUseCase extends StateNotifier<Address?>{
  UserLocationUseCase():super(null);

  void updateUserLocation(Address? address){
    state = address;
  }

}