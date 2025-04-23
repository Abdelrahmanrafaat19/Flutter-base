import 'package:flutter_base/core/models/StateModel.dart';
import 'package:flutter_base/features/restaurant_details/domain/entities/restaurant_entity.dart';
import 'package:flutter_base/features/restaurant_details/domain/providers/restaurants_repository_provider.dart';
import 'package:flutter_base/features/restaurant_details/domain/usecases/fetch_restaurant_details_use_case.dart';
import 'package:flutter_base/features/restaurant_details/domain/usecases/fetch_restaurant_details_use_case.dart';
import 'package:flutter_base/features/restaurant_details/domain/usecases/fetch_restaurant_menu_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/menu_entity.dart';

final fetchRestaurantMenuStateProvider = StateNotifierProvider.autoDispose<
        FetchRestaurantMenuUseCase, StateModel<RestaurantMenuEntity>>(
    (ref) =>
        FetchRestaurantMenuUseCase(ref.read(restaurantRepositoryProvider)));

final fetchRestaurantDetailsStateProvider = StateNotifierProvider.autoDispose<
        FetchRestaurantDetailsUseCase, StateModel<RestaurantDetailsEntity>>(
    (ref) =>
        FetchRestaurantDetailsUseCase(ref.read(restaurantRepositoryProvider)));
