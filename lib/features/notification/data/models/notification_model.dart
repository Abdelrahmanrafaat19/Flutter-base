import '../../domain/entities/notification_entity.dart';

class NotificationModel {
  String? createdAt;
  num? id;
  String? image;
  String? imagePath;
  num? isRead;
  num? orderId;
  String? type;
  String? notification;
  String? notificationAr;
  String? notificationEn;
  String? title;
  String? titleAr;
  String? titleEn;
  String? updatedAt;
  Object? user;
  Object? userId;

  NotificationModel({
    this.createdAt,
    this.id,
    this.image,
    this.imagePath,
    this.isRead,
    this.orderId,
    this.type,
    this.notification,
    this.notificationAr,
    this.notificationEn,
    this.title,
    this.titleAr,
    this.titleEn,
    this.updatedAt,
    this.user,
    this.userId,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    id = json['id'];
    image = json['image'];
    imagePath = json['imagePath'];
    isRead = json['isRead'];
    orderId = json['orderId'];
    type = json['type'];
    notification = json['notification'];
    notificationAr = json['notificationAr'];
    notificationEn = json['notificationEn'];
    title = json['title'];
    titleAr = json['titleAr'];
    titleEn = json['titleEn'];
    updatedAt = json['updatedAt'];
    user = json['user'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['id'] = this.id;
    data['image'] = this.image;
    data['imagePath'] = this.imagePath;
    data['isRead'] = this.isRead;
    data['orderId'] = this.orderId;
    data['type'] = this.type;
    data['notification'] = this.notification;
    data['notificationAr'] = this.notificationAr;
    data['notificationEn'] = this.notificationEn;
    data['title'] = this.title;
    data['titleAr'] = this.titleAr;
    data['titleEn'] = this.titleEn;
    data['updatedAt'] = this.updatedAt;
    data['user'] = this.user;
    data['userId'] = this.userId;
    return data;
  }
}

NotificationEntity toNotificationEntity(NotificationModel notificationModel) {
  return NotificationEntity(
    createdAt: notificationModel.createdAt,
    id: notificationModel.id,
    imagePath: notificationModel.imagePath,
    isRead: notificationModel.isRead,
    notification: notificationModel.notification,
    title: notificationModel.title,
    updatedAt: notificationModel.updatedAt
  );
}
