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
}
