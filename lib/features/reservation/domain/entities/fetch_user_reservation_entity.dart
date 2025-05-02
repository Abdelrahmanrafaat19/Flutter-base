import '../../data/models/rs_restaurant.dart';

class ReservedRestaurantEntity {
  final int? id;
  final RsRestaurant? rsRestaurant;
  final String? reservationDate;
  final int? guestCount;
  final String? status;
  final bool? reminder;
  final String? occassion;
  final String? guestName;
  final String? guestPhone;
  final String? createdAt;

  ReservedRestaurantEntity({
    this.id,
    this.rsRestaurant,
    this.reservationDate,
    this.guestCount,
    this.status,
    this.occassion,
    this.guestName,
    this.reminder,
    this.guestPhone,
    this.createdAt,
  });

  ReservedRestaurantEntity copyWith({
    int? id,
    RsRestaurant? rsRestaurant,
    String? reservationDate,
    int? guestCount,
    String? status,
    String? occassion,
    String? guestName,
    String? guestPhone,
    String? createdAt,
    bool? reminder
  }) {
    return ReservedRestaurantEntity(
      id: id ?? this.id,
      rsRestaurant: rsRestaurant ?? this.rsRestaurant,
      reservationDate: reservationDate ?? this.reservationDate,
      guestCount: guestCount ?? this.guestCount,
      status: status ?? this.status,
      occassion: occassion ?? this.occassion,
      guestName: guestName ?? this.guestName,
      guestPhone: guestPhone ?? this.guestPhone,
      createdAt: createdAt ?? this.createdAt,
      reminder: reminder??this.reminder,
    );
  }
}
