class Address {
  final String placeName;
  final double latitude;
  final double longitude;
  final String description;

  Address({
    required this.placeName,
    required this.latitude,
    required this.longitude,
    required this.description,
  });

  factory Address.fromJsonWithLatLng(Map<String, dynamic> prediction, double lat, double lng) {
    return Address(
      placeName: prediction['structured_formatting']?['main_text'] ?? prediction['description'],
      latitude: lat,
      longitude: lng,
      description: prediction['description'],
    );
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      placeName: json['placeName'] ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'placeName': placeName,
    'latitude': latitude,
    'longitude': longitude,
    'description': description,
  };
}