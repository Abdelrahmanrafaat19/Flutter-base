import '../../domain/entities/menu_category_entity.dart';
import 'menu_item_model.dart';
import 'menu_model.dart';

class MenuCategoryModel {
  final int categoryId;
  final String? categoryName;
  final String? mainImage;
  final List<MenuItemModel>? rsItemList;

  MenuCategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.mainImage,
    required this.rsItemList,
  });

  factory MenuCategoryModel.fromJson(Map<String, dynamic> json) =>
      MenuCategoryModel(
        categoryId: json['categoryId'],
        categoryName: json['categoryName'],
        mainImage: json['mainImage'],
        rsItemList: (json['rsItemList'] as List)
            .map((e) => MenuItemModel.fromJson(e))
            .toList(),
      );

  MenuCategoryEntity toEntity() => MenuCategoryEntity(
    categoryId: categoryId,
    categoryName: categoryName,
    mainImage: mainImage,
    rsItemList: rsItemList?.map((e) => e.toEntity()).toList(),
  );
}
