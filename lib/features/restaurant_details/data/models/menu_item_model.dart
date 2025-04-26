import '../../domain/entities/menu_item_entity.dart';

class MenuItemModel {
  final int id;
  final int? menuId;
  final String? name;
  final String? description;
  final int? categoryId;
  final double? price;
  final double? discount;
  final bool? available;
  final String? image;

  MenuItemModel({
    required this.id,
    required this.menuId,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.price,
    required this.discount,
    required this.available,
    required this.image,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) => MenuItemModel(
    id: json['id'],
    menuId: json['menuId'],
    name: json['name'],
    description: json['description'],
    categoryId: json['categoryId'],
    price: (json['price'] as num).toDouble(),
    discount: (json['discount'] as num).toDouble(),
    available: json['available'],
    image: json['image'],
  );

  MenuItemEntity toEntity() => MenuItemEntity(
    id: id,
    menuId: menuId,
    name: name,
    description: description,
    categoryId: categoryId,
    price: price,
    discount: discount,
    available: available,
    image: image,
  );
}
