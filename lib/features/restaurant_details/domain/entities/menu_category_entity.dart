import 'menu_item_entity.dart';

class MenuCategoryEntity {
  final int categoryId;
  final String? categoryName;
  final String? mainImage;
  final List<MenuItemEntity>? rsItemList;

  MenuCategoryEntity({
    required this.categoryId,
    required this.categoryName,
    required this.mainImage,
    required this.rsItemList,
  });
}
