import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/StateModel.dart';
import '../../data/models/avilable_time_model.dart';
import '../../domain/entities/fetch_user_reservation_entity.dart';
import '../../domain/providers/reservation_repo_provider.dart';
import '../../domain/use_case/create_reservation_use_case.dart';
import '../../domain/use_case/fetch_avaialble_meal_time_use_case.dart';
import '../../domain/use_case/fetch_single_reservation_use_case.dart';
import '../../domain/use_case/fetch_user_reservation_use_case.dart';
import '../../domain/use_case/reminder_trigger_use_case.dart';

final fetchReservedUserRestaurantUseCaseProvider =
StateNotifierProvider.autoDispose<FetchUserReservationUseCase,StateModel<List<ReservedRestaurantEntity>>>(
        (ref) => FetchUserReservationUseCase(ref, ref.read(reservationRepoProvider)));


final createReservationUserRestaurantUseCaseProvider =
StateNotifierProvider.autoDispose<CreateReservationUseCase,StateModel<ReservedRestaurantEntity>>(
        (ref) => CreateReservationUseCase(ref, ref.read(reservationRepoProvider)));
final fetchSingleReservationUserRestaurantUseCaseProvider =
StateNotifierProvider.autoDispose<FetchSingleReservationUseCase,StateModel<List<ReservedRestaurantEntity>>>(
        (ref) => FetchSingleReservationUseCase(ref, ref.read(reservationRepoProvider)));
final reminderTriggerUseCaseProvider =
StateNotifierProvider.autoDispose<ReminderTriggerUseCase,StateModel<ReservedRestaurantEntity>>(
        (ref) => ReminderTriggerUseCase(ref, ref.read(reservationRepoProvider)));


final availableMealTimeUseCaseProvider =
StateNotifierProvider.autoDispose<FetchAvaialbleMealTimeUseCase,StateModel<AvaliableTimeModel>>(
        (ref) => FetchAvaialbleMealTimeUseCase(ref, ref.read(reservationRepoProvider)));