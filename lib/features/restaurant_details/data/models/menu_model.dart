import '../../domain/entities/menu_entity.dart';
import '../../domain/entities/menu_item_entity.dart';
import 'menu_category_model.dart';

class RestaurantMenuModel {
  final int id;
  final int? restaurantId;
  final List<MenuCategoryModel>? categoryItems;

  RestaurantMenuModel({
    required this.id,
    required this.restaurantId,
    required this.categoryItems,
  });

  factory RestaurantMenuModel.fromJson(Map<String, dynamic> json) => RestaurantMenuModel(
    id: json['id'],
    restaurantId: json['restaurantId'],
    categoryItems: (json['categoryItems'] as List)
        .map((e) => MenuCategoryModel.fromJson(e))
        .toList(),
  );

  RestaurantMenuEntity toEntity() => RestaurantMenuEntity(
    id: id,
    restaurantId: restaurantId,
    categoryItems: categoryItems?.map((e) => e.toEntity()).toList(),
  );
}