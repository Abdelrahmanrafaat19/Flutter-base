import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_base/features/search/domain/entities/resturant_entity.dart';
import 'package:flutter_base/features/search/domain/use_cases/search_on_restaurant_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/restaurant_repo_provider.dart';
import '../../domain/use_cases/fetch_restaurant_data_use_case.dart';

final fetchRestaurantDataStateNotifierProvider =
    StateNotifierProvider.autoDispose<FetchRestaurantDataUseCase,
        StateModel<List<RestaurantEntity>>>(
  (ref) => FetchRestaurantDataUseCase(
    ref,
    ref.read(restaurantRepoProvider),
  ),
);
final searchOnRestaurantDataStateNotifierProvider = StateNotifierProvider
    .autoDispose<SearchOnRestaurantUseCase, StateModel<List<RestaurantEntity>>>(
  (ref) => SearchOnRestaurantUseCase(
    ref,
    ref.read(restaurantRepoProvider),
  ),
);
