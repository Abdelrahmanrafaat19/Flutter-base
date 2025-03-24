import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_base/features/common/domain/usecases/resturant_search_usecase.dart';
import 'package:flutter_base/features/home/domain/entities/restaurant_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/providers/common_repository_providers.dart';

final restaurantSearchProvider = StateNotifierProvider.autoDispose<RestaurantSearchUseCase,StateModel<List<Restaurant>>>((ref) {
  return RestaurantSearchUseCase(ref,ref.read(commonRepoProvider));
});