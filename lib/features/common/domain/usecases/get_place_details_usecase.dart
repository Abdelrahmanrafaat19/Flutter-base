import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/models/StateModel.dart';
import '../repositories/common_repository.dart';

class GetLatLngFromPlaceIdUseCase extends StateNotifier<StateModel<LatLng?>> {
  final CommonRepository _commonRepository;

  GetLatLngFromPlaceIdUseCase(this._commonRepository) : super(StateModel());

  Future<void> call(String placeId) async {
    state = StateModel.loading();

    try {
      final location = await _commonRepository.getLatLngFromPlaceId(placeId);
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

