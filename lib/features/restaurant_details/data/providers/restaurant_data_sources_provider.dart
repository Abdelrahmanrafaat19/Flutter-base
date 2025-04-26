import 'package:flutter_base/core/providers/http_provider.dart';
import 'package:flutter_base/features/restaurant_details/data/datasources/restaurant_data_sources.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantDataSourcesProvider = Provider<RestaurantDataSources>(
    (ref) => RestaurantDataSources(ref.read(httpOperationsProvider)));
