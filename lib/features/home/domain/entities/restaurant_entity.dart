import '../../../restaurant_details/data/models/location_model.dart';

class RestaurantSummaryEntity {
  final int? id;
  final String? name;
  final String? address;
  final LocationModel? location;
  final int? cuisineId;
  final bool? isOpen;
  final double? distance;
  final double? rating;
  bool? isFavorite;

  RestaurantSummaryEntity({
    this.id,
    this.name,
    this.address,
    this.location,
    this.cuisineId,
    this.isOpen,
    this.distance,
    this.rating,
    this.isFavorite,
  });
  RestaurantSummaryEntity copyWith({
    int? id,
    String? name,
    String? address,
    LocationModel? location,
    int? cuisineId,
    bool? isOpen,
    double? distance,
    double? rating,
    bool? isFavorite,
  }) {
    return RestaurantSummaryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      location: location ?? this.location,
      cuisineId: cuisineId ?? this.cuisineId,
      isOpen: isOpen ?? this.isOpen,
      distance: distance ?? this.distance,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
