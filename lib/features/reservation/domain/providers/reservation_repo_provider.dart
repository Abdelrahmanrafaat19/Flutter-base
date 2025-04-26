import 'package:flutter_base/features/reservation/data/respositries/reservation_resturant_repo_imple.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers/reservation_data_source.dart';
import '../repositories/reservation_resturant_repo.dart';

final reservationRepoProvider = Provider<ReservationResturantRepo>((ref)  {
  return ReservationResturantRepoImple(ref.watch(reservedRestaurantDataSourceProvider));
});