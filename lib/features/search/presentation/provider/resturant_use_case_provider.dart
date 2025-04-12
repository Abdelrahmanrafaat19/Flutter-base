import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../home/domain/entities/restaurant_entity.dart';
import '../../domain/providers/restaurant_repo_provider.dart';

import '../../domain/use_cases/search_Restaurant_by_name.dart';


final searchOnRestaurantByNameDataStateNotifierProvider = StateNotifierProvider
    .autoDispose<SearchOnRestaurantByNameUseCase, StateModel<List<String>>>(
      (ref) => SearchOnRestaurantByNameUseCase(
    ref,
    ref.read(restaurantRepoProvider),
  ),
);