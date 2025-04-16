import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/models/StateModel.dart';
import '../../../permissions/data/model/address_model.dart';
import '../repositories/common_repository.dart';

class GetLatLngFromLatLngUseCase extends StateNotifier<StateModel<Address?>> {
  final CommonRepository _commonRepository;

  GetLatLngFromLatLngUseCase(this._commonRepository) : super(StateModel());

  Future<void> call(double lat, double lng) async {
    state = StateModel.loading();

    try {
      final location = await _commonRepository.getAddressFromLatLng(lat,lng);
      state = StateModel(
        state: DataState.SUCCESS,
        data: location,
      );
    } catch (e) {
      state = StateModel(
        state: DataState.ERROR,
        message: e.toString(),
      );
    }
  }

}

