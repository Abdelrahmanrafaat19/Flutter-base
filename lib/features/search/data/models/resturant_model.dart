// import '../../domain/entities/resturant_entity.dart';
// import 'restaurant_data.dart';
//
// class RestaurantModel {
//   List<RastaurantData>? data;
//   int? code;
//   String? message;
//   Null? errors;
//
//   RestaurantModel({this.data, this.code, this.message, this.errors});
//
//   RestaurantModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <RastaurantData>[];
//       json['data'].forEach((v) {
//         data!.add(new RastaurantData.fromJson(v));
//       });
//     }
//     code = json['code'];
//     message = json['message'];
//     errors = json['errors'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['code'] = this.code;
//     data['message'] = this.message;
//     data['errors'] = this.errors;
//     return data;
//   }
// }
//
// List<RestaurantEntity> toRestaurantEntity(RestaurantModel restaurantModel) {
//   List<RestaurantEntity> data = [];
//   restaurantModel.data!.forEach(
//     (element) {
//       return data.add(
//         RestaurantEntity(
//           name: element.name,
//           address: element.address,
//           rating: element.rating,
//         ),
//       );
//     },
//   );
//   return data;
// }
