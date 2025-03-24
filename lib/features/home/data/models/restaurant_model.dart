import '../../domain/entities/restaurant_entity.dart';

class RestaurantModel {
  final int? id;
  final String? name;
  final String? phone;
  final String? address;
  final String? location;
  final int? cuisineId;
  final List<int>? categoryIds;
  final List<String>? certifications;
  final bool? isOpen;
  final double? distance;
  final double? rating;
  final int? capacity;
  final double? cancellationFee;

  RestaurantModel(
      {this.id,
      this.name,
      this.phone,
      this.address,
      this.location,
      this.cuisineId,
      this.categoryIds,
      this.certifications,
      this.isOpen,
      this.distance,
      this.rating,
      this.capacity,
      this.cancellationFee});

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      location: json['location'],
      cuisineId: json['cuisineId'],
      categoryIds: List<int>.from(json['categoryIds']),
      certifications: List<String>.from(json['certifications']),
      isOpen: json['isOpen'],
      distance: json['distance'],
      rating: json['rating'].toDouble(),
      capacity: json['capacity'],
      cancellationFee: json['cancellationFee'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'location': location,
      'cuisineId': cuisineId,
      'categoryIds': categoryIds,
      'I/certifications': certifications,
      'isOpen': isOpen,
      'distance': distance,
      'rating': rating,
      'capacity': capacity,
      'cancellationFee': cancellationFee,
    };
  }

  // Convert Model to Entity


  // Convert Entity to Model
  RestaurantModel fromEntity(Restaurant entity) {
    return RestaurantModel(
      id: entity.id,
      name: entity.name,
      address: entity.address,
      location: entity.location,
      cuisineId: entity.cuisineId,
      isOpen: entity.isOpen,
      distance: entity.distance,
      rating: entity.rating,
      capacity: entity.capacity,
    );
  }
}
Restaurant toRestaurantEntity(RestaurantModel restaurant) {
  return Restaurant(
    id: restaurant.id,
    name: restaurant.name,
    address: restaurant.address,
    location: restaurant.location,
    cuisineId: restaurant.cuisineId,
    isOpen: restaurant.isOpen,
    distance: restaurant.distance,
    rating: restaurant.rating,
    capacity: restaurant.capacity,
  );
}