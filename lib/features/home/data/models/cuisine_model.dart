import 'package:flutter_base/features/home/data/models/restaurant_model.dart';
import 'package:flutter_base/features/home/domain/entities/cuisine_entity.dart';

class CuisineModel {
  final int? id;
  final String? name;
  final String? image;
  final bool? featured;

  CuisineModel({
    this.id,
    this.name,
    this.image,
    this.featured,
  });


  factory CuisineModel.fromJson(Map<String, dynamic> json) {
    return CuisineModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      featured: json['featured'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'featured': featured,
    };
  }

}
Cuisine toCuisineEntity(CuisineModel cuisine) {
  return Cuisine(
    id: cuisine.id,
    name: cuisine.name,
    image: cuisine.image,
    featured: cuisine.featured,
  );
}