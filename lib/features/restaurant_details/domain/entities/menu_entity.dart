import 'menu_category_entity.dart';

class RestaurantMenuEntity {
  final int id;
  final int? restaurantId;
  final List<MenuCategoryEntity>? categoryItems;

  RestaurantMenuEntity({
    required this.id,
    required this.restaurantId,
    required this.categoryItems,
  });
}


