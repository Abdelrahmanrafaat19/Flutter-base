import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_base/features/common/domain/usecases/resturant_search_usecase.dart';
import 'package:flutter_base/features/home/domain/entities/restaurant_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/providers/common_repository_providers.dart';
import '../../domain/usecases/get_place_details_usecase.dart';
import '../../domain/usecases/get_suggestions_usecase.dart';
import '../../domain/usecases/update_favorite_resturant_state_usecase.dart';

final restaurantSearchProvider = StateNotifierProvider.autoDispose<
    RestaurantSearchUseCase, StateModel<List<Restaurant>>>((ref) {
  return RestaurantSearchUseCase(ref, ref.read(commonRepoProvider));
});

final updateFavoriteRestaurantStateProvider = StateNotifierProvider.autoDispose<
    UpdateFavoriteRestaurantStateUseCase, StateModel<int>>((ref) {
  return UpdateFavoriteRestaurantStateUseCase(
      ref, ref.read(commonRepoProvider));
});

final getSuggestionsUseCaseProvider = StateNotifierProvider.autoDispose<
    GetSuggestionsUseCase, StateModel<List<dynamic>>>((ref) {
  final repo = ref.read(commonRepoProvider);
  return GetSuggestionsUseCase(repo);
});

final getLatLngFromPlaceIdUseCaseProvider = StateNotifierProvider.autoDispose<
    GetLatLngFromPlaceIdUseCase, StateModel<LatLng?>>((ref) {
  return GetLatLngFromPlaceIdUseCase(ref.read(commonRepoProvider));
});
