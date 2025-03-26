import 'package:flutter_base/features/home/domain/entities/restaurant_entity.dart';

class Cuisine {
  final int? id;
  final String? name;
  final String? image;
  final bool? featured;

  Cuisine({
    this.id,
    this.name,
    this.image,
    this.featured,
  });
}
