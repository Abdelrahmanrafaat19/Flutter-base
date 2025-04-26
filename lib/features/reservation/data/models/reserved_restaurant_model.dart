import 'package:flutter_base/features/reservation/data/models/rs_restaurant.dart';

import '../../domain/entities/fetch_user_reservation_entity.dart';

class ReservedRestaurantModel {
  int? id;
  RsRestaurant? rsRestaurant;
  String? reservationDate;
  int? guestCount;
  String? status;
  String? occassion;
  String? guestName;
  String? guestPhone;
  String? createdAt;

  ReservedRestaurantModel(
      {this.id,
        this.rsRestaurant,
        this.reservationDate,
        this.guestCount,
        this.status,
        this.occassion,
        this.guestName,
        this.guestPhone,
        this.createdAt});

  ReservedRestaurantModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rsRestaurant = json['rsRestaurant'] != null
        ? new RsRestaurant.fromJson(json['rsRestaurant'])
        : null;
    reservationDate = json['reservationDate'];
    guestCount = json['guestCount'];
    status = json['status'];
    occassion = json['occassion'];
    guestName = json['guestName'];
    guestPhone = json['guestPhone'];
    createdAt = json['createdAt'];
  }
}

ReservedRestaurantEntity toReservedRestaurantEntity(ReservedRestaurantModel model) {
  return ReservedRestaurantEntity(
    id: model.id,
    rsRestaurant: model.rsRestaurant, // You can convert to entity if needed
    reservationDate: model.reservationDate,
    guestCount: model.guestCount,
    status: model.status,
    occassion: model.occassion,
    guestName: model.guestName,
    guestPhone: model.guestPhone,
    createdAt: model.createdAt,
  );
}