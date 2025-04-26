import '../../domain/entities/ReviewEntity.dart';

class ReviewModel {
  final int? id;
  final String? userName;
  final int? rating;
  final String? comment;
  final String? createdAt;

  ReviewModel({
    this.id,
    this.userName,
    this.rating,
    this.comment,
    this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      userName: json['userName'],
      rating: json['rating'],
      comment: json['comment'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt,
    };
  }

  ReviewEntity toEntity() {
    return ReviewEntity(
      id: id,
      userName: userName,
      rating: rating,
      comment: comment,
      createdAt: createdAt,
    );
  }
}
