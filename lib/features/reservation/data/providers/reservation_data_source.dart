import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/http_provider.dart';
import '../data_source/reserved_restaurant_data_source.dart';

final reservedRestaurantDataSourceProvider =
    Provider<ReservedRestaurantDataSource>(
  (ref) {
    final httpOps = ref.read(httpOperationsProvider); // HttpOps Provider
    return ReservedRestaurantDataSource(httpOps);
  },
);
