
import '../../../restaurant_details/data/models/restaurant_model.dart';
import '../../domain/entities/category_entity.dart';

class CategoryModel {
  final int? id;
  final String? description;
  final int? parentId;
  final bool? fetchRestaurants;
  final List<RestaurantModel>? rsRestaurants;
  final bool? featured;

  CategoryModel({
    this.id,
    this.description,
    this.parentId,
    this.fetchRestaurants,
    this.rsRestaurants,
    this.featured,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      description: json['description'],
      parentId: json['parentId'],
      fetchRestaurants: json['fetchRestaurants'],
      rsRestaurants: (json['rsRestaurants'] as List)
          .map((restaurant) => RestaurantModel.fromJson(restaurant))
          .toList(),
      featured: json['featured'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'parentId': parentId,
      'fetchRestaurants': fetchRestaurants,
      'rsRestaurants':
          rsRestaurants?.map((r) => (r).toJson()).toList(),
      'featured': featured,
    };
  }


}
CategoryEntity toCategoryEntity(CategoryModel model) {
  return CategoryEntity(
    id: model.id,
    description: model.description,
    parentId: model.parentId,
    fetchRestaurants: model.fetchRestaurants,
    rsRestaurants: model.rsRestaurants?.map((r) => r.toRestaurantSummaryEntity()).toList(),
    featured: model.featured,
  );
}