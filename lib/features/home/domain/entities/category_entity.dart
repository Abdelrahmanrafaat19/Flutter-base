import 'package:flutter_base/features/home/domain/entities/restaurant_entity.dart';

class CategoryEntity {
  final int? id;
  final String? description;
  final int? parentId;
  final bool? fetchRestaurants;
  final List<Restaurant>? rsRestaurants;
  final bool? featured;

  CategoryEntity({
    this.id,
    this.description,
    this.parentId,
    this.fetchRestaurants,
    this.rsRestaurants,
    this.featured,
  });
  CategoryEntity copyWith({
    int? id,
    String? description,
    int? parentId,
    bool? fetchRestaurants,
    List<Restaurant>? rsRestaurants,
    bool? featured,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      description: description ?? this.description,
      parentId: parentId ?? this.parentId,
      fetchRestaurants: fetchRestaurants ?? this.fetchRestaurants,
      rsRestaurants: rsRestaurants ?? this.rsRestaurants,
      featured: featured ?? this.featured,
    );
  }
}

