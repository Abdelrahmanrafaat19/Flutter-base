import 'package:flutter_base/features/restaurant_details/data/models/quick_reservation_slot_model.dart';
import 'package:flutter_base/features/restaurant_details/data/models/tag_model.dart';
import '../../../home/domain/entities/restaurant_entity.dart';
import '../../domain/entities/restaurant_entity.dart';
import 'location_model.dart';

class RestaurantModel {
  final String? name;
  final String? phone;
  final String? address;
  final LocationModel? location;
  final int? cuisineId;
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
  final int? id;
  final bool? isFavorite;
  final double? distance;
  final int? reservationsCount;
  final int? reviewsCount;
  final int? maxDiscount;
  final String? cuisineName;
  final List<TagModel>? tags;
  final List<QuickReservationSlotModel>? quickReservationTimeSlots;

  RestaurantModel({
    this.name,
    this.phone,
    this.address,
    this.location,
    this.cuisineId,
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
    this.id,
    this.isFavorite,
    this.distance,
    this.reservationsCount,
    this.reviewsCount,
    this.maxDiscount,
    this.cuisineName,
    this.tags,
    this.quickReservationTimeSlots,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      cuisineId: json['cuisineId'],
      rating: (json['rating'] as num?)?.toDouble(),
      capacity: json['capacity'],
      cancellationFee: json['cancellationFee'],
      categoryIds: (json['categoryIds'] as List?)?.map((e) => e as int).toList(),
      certifications: (json['certifications'] as List?)?.map((e) => e as String).toList(),
      singleReservationCost: json['singleReservationCost'],
      openTime: json['openTime'],
      closeTime: json['closeTime'],
      imageUrls: (json['imageUrls'] as List?)?.map((e) => e as String).toList(),
      mainImage: json['mainImage'],
      id: json['id'],
      isFavorite: json['isFavorite'],
      distance: (json['distance'] as num?)?.toDouble(),
      reservationsCount: json['reservationsCount'],
      reviewsCount: json['reviewsCount'],
      maxDiscount: json['maxDiscount'],
      cuisineName: json['cuisineName'],
      tags: (json['tags'] as List?)
          ?.map((e) => TagModel.fromJson(e))
          .toList(),
      quickReservationTimeSlots: (json['quickReservationTimeSlots'] as List?)
          ?.map((e) => QuickReservationSlotModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'location': location?.toJson(),
      'cuisineId': cuisineId,
      'rating': rating,
      'capacity': capacity,
      'cancellationFee': cancellationFee,
      'categoryIds': categoryIds,
      'certifications': certifications,
      'singleReservationCost': singleReservationCost,
      'openTime': openTime,
      'closeTime': closeTime,
      'imageUrls': imageUrls,
      'mainImage': mainImage,
      'id': id,
      'isFavorite': isFavorite,
      'distance': distance,
      'reservationsCount': reservationsCount,
      'reviewsCount': reviewsCount,
      'maxDiscount': maxDiscount,
      'cuisineName': cuisineName,
      'tags': tags?.map((e) => e.toJson()).toList(),
      'quickReservationTimeSlots': quickReservationTimeSlots?.map((e) => e.toJson()).toList(),
    };
  }

  RestaurantDetailsEntity toRestaurantDetailsEntity() {
    return RestaurantDetailsEntity(
      id: id,
      name: name,
      phone: phone,
      address: address,
      location: location?.toEntity(),
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
      isFavorite: isFavorite,
      distance: distance,
      reservationsCount: reservationsCount,
      reviewsCount: reviewsCount,
      maxDiscount: maxDiscount,
      tags: tags?.map((e) => e.toEntity()).toList(),
      quickReservationTimeSlots:
      quickReservationTimeSlots?.map((e) => e.toEntity()).toList(),
    );
  }

  RestaurantSummaryEntity toRestaurantSummaryEntity() {
    return RestaurantSummaryEntity(
        id:id,
        name: name,
        address: address,
        location: location,
        cuisineId: cuisineId,
        distance: distance,
        rating: rating,
        isFavorite: isFavorite
    );
  }
}