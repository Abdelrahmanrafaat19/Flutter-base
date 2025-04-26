class RsRestaurantLocation {
  String? lat;
  String? lon;

  RsRestaurantLocation({this.lat, this.lon});

  RsRestaurantLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }


}