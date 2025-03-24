import 'package:flutter_base/features/search/data/providers/restaurant_data_source_provider.dart';
import 'package:flutter_base/features/search/data/repositories/restaurant_repo_imple.dart';
import 'package:flutter_base/features/search/domain/repositories/restaurant_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantRepoProvider = Provider<RestaurantRepo>(
  (ref) {
    return RestaurantRepoImple(
      ref.watch(
        restaurantDataSourceProvider,
      ),
    );
  },
);
