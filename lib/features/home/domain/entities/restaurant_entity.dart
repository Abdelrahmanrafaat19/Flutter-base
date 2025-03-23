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


  Restaurant(
      {this.id,
        this.name,
        this.address,
        this.location,
        this.cuisineId,
        this.isOpen,
        this.distance,
        this.rating,
        this.capacity});
}
