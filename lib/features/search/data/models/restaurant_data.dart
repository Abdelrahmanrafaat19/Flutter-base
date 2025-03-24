class RastaurantData {
  int? id;
  String? name;
  String? phone;
  String? address;
  String? location;
  int? cuisineId;
  List<int>? categoryIds;
  List<String>? certifications;
  bool? isOpen;
  Null? distance;
  double? rating;
  int? capacity;
  int? cancellationFee;

  RastaurantData(
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

  RastaurantData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    location = json['location'];
    cuisineId = json['cuisineId'];
    categoryIds = json['categoryIds'].cast<int>();
    certifications = json['certifications'].cast<String>();
    isOpen = json['isOpen'];
    distance = json['distance'];
    rating = json['rating'];
    capacity = json['capacity'];
    cancellationFee = json['cancellationFee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['location'] = this.location;
    data['cuisineId'] = this.cuisineId;
    data['categoryIds'] = this.categoryIds;
    data['certifications'] = this.certifications;
    data['isOpen'] = this.isOpen;
    data['distance'] = this.distance;
    data['rating'] = this.rating;
    data['capacity'] = this.capacity;
    data['cancellationFee'] = this.cancellationFee;
    return data;
  }
}