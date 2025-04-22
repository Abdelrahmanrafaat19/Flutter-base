class MenuItemEntity {
  final int? id;
  final int? menuId;
  final String? name;
  final String? description;
  final int? categoryId;
  final double? price;
  final double? discount;
  final bool? available;
  final String? image;

  MenuItemEntity({
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
}
