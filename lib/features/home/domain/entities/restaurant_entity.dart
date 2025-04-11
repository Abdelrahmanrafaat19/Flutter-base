class Restaurant {
  final int? id;
  final String? name;
  final String? address;
  final String? location;
  final int? cuisineId;
  final bool? isOpen;
  final double? distance;
  final double? rating;
  final int? capacity;
  bool? isFavorite;


  Restaurant(
      {this.id,
        this.name,
        this.address,
        this.location,
        this.cuisineId,
        this.isOpen,
        this.distance,
        this.rating,
        this.capacity,this.isFavorite,});
  Restaurant copyWith({
    int? id,
    String? name,
    String? address,
    String? location,
    int? cuisineId,
    bool? isOpen,
    double? distance,
    double? rating,
    int? capacity,
    bool? isFavorite,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      location: location ?? this.location,
      cuisineId: cuisineId ?? this.cuisineId,
      isOpen: isOpen ?? this.isOpen,
      distance: distance ?? this.distance,
      rating: rating ?? this.rating,
      capacity: capacity ?? this.capacity,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
