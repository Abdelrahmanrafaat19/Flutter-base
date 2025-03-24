import 'package:flutter_base/features/search/data/data_source/restaurant_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/http_provider.dart';

final restaurantDataSourceProvider= Provider<RestaurantDataSource>((ref) {
  final httpOps = ref.read(httpOperationsProvider); // HttpOps Provider
  return RestaurantDataSource(httpOps);
});