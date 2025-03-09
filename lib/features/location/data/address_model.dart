class Address {
  final String placeName;

  final double latitude;
  final double longitude;

  Address(
      {required this.placeName,
      required this.latitude,
      required this.longitude});

  // Convert Address object to JSON
  Map<String, dynamic> toJson() {
    return {
      'placeName': placeName,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // Create Address object from JSON
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      placeName: json['placeName'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
