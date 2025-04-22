import 'package:flutter_base/features/restaurant_details/data/providers/restaurant_data_sources_provider.dart';
import 'package:flutter_base/features/restaurant_details/data/repository/restaurant_repository_imp.dart';
import 'package:flutter_base/features/restaurant_details/domain/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>(
    (ref) => RestaurantRepositoryImp(ref.read(restaurantDataSourcesProvider)));
