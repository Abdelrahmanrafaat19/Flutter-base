import '../../../../core/constants/eunms.dart';

class ItemSelector{
  int? id;
  String? name;
  String? image;

  ItemSelector({this.id, this.name, this.image});
}

class FilterItemSelector{
  int? id;
  String? name;
  String? image;
  FilterType? type;

  FilterItemSelector({this.id, this.name, this.image, this.type});
}