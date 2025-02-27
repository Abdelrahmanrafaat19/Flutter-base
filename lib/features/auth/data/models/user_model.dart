import '../../domain/entities/user_entity.dart';
import '../../../../core/network/api_endpoints.dart';

class UserModel {
  String? token;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;

  UserModel(
      {this.token,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNumber});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}

User toUserEntity(UserModel user){ // Convert UserModel to UserEntity
  return User(
      firstName: user.firstName,
      lastName: user.lastName,
      phoneNumber: user.phoneNumber,
      email: user.email,
      token: user.token
  );
}