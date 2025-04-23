import '../../domain/entities/tag_entity.dart';

class TagModel {
  final int id;
  final String text;

  TagModel({required this.id, required this.text});

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(id: json['id'], text: json['text']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
    };
  }

  TagEntity toEntity() => TagEntity(id: id, text: text);
}