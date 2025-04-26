import '../../domain/entities/quick_reservation_slot_entity.dart';

class QuickReservationSlotModel {
  final String? reservationTime;
  final bool? availability;

  QuickReservationSlotModel({
    required this.reservationTime,
    required this.availability,
  });

  factory QuickReservationSlotModel.fromJson(Map<String, dynamic> json) {
    return QuickReservationSlotModel(
      reservationTime: json['reservationTime'],
      availability: json['availability'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reservationTime': reservationTime,
      'availability': availability,
    };
  }

  QuickReservationSlotEntity toEntity() => QuickReservationSlotEntity(
      reservationTime: reservationTime, availability: availability);
}