import 'package:flutter_base/features/reservation/data/models/rs_restaurant_location.dart';

class RsRestaurant {
  dynamic id;
  String? name;
  String? cuisineName;
  String? address;
  RsRestaurantLocation? location;
  dynamic rating;
  String? mainImage;

  RsRestaurant(
      {this.id,
        this.name,
        this.cuisineName,
        this.address,
        this.location,
        this.rating,
        this.mainImage});

  RsRestaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cuisineName = json['cuisineName'];
    address = json['address'];
    location = json['location'] != null
        ? new RsRestaurantLocation.fromJson(json['location'])
        : null;
    rating = json['rating'];
    mainImage = json['mainImage'];
  }


}
