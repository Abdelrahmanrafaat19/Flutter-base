import 'package:flutter_base/features/restaurant_details/domain/entities/quick_reservation_slot_entity.dart';
import 'package:flutter_base/features/restaurant_details/domain/entities/tag_entity.dart';

import 'location_entity.dart';

class RestaurantDetailsEntity {
  final int? id;
  final String? name;
  final String? phone;
  final String? address;
  final LocationEntity? location;
  final int? cuisineId;
  final String? cuisineName;
  final double? rating;
  final int? capacity;
  final double? cancellationFee;
  final List<int>? categoryIds;
  final List<String>? certifications;
  final int? singleReservationCost;
  final String? openTime;
  final String? closeTime;
  final List<String>? imageUrls;
  final String? mainImage;
  final bool? isFavorite;
  final double? distance;
  final int? reservationsCount;
  final int? reviewsCount;
  final int? maxDiscount;
  final List<TagEntity>? tags;
  final List<QuickReservationSlotEntity>? quickReservationTimeSlots;

  RestaurantDetailsEntity({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.location,
    this.cuisineId,
    this.cuisineName,
    this.rating,
    this.capacity,
    this.cancellationFee,
    this.categoryIds,
    this.certifications,
    this.singleReservationCost,
    this.openTime,
    this.closeTime,
    this.imageUrls,
    this.mainImage,
    this.isFavorite,
    this.distance,
    this.reservationsCount,
    this.reviewsCount,
    this.maxDiscount,
    this.tags,
    this.quickReservationTimeSlots,
  });

  RestaurantDetailsEntity copyWith({
    bool? isFavorite,
  }) {
    return RestaurantDetailsEntity(
      id: id,
      name: name,
      phone: phone,
      address: address,
      location: location,
      cuisineId: cuisineId,
      cuisineName: cuisineName,
      rating: rating,
      capacity: capacity,
      cancellationFee: cancellationFee,
      categoryIds: categoryIds,
      certifications: certifications,
      singleReservationCost: singleReservationCost,
      openTime: openTime,
      closeTime: closeTime,
      imageUrls: imageUrls,
      mainImage: mainImage,
      isFavorite: isFavorite ?? this.isFavorite,
      distance: distance,
      reservationsCount: reservationsCount,
      reviewsCount: reviewsCount,
      maxDiscount: maxDiscount,
      tags: tags,
      quickReservationTimeSlots: quickReservationTimeSlots,
    );
  }

}
