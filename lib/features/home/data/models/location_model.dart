class LocationModel {
  final double? lat;
  final double? lon;

  LocationModel({this.lat, this.lon});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      lat: json['lat'],
      lon: json['lon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
    };
  }
}
