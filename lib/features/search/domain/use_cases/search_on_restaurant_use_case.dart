// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../../core/models/ResponseModel.dart';
// import '../../../../core/models/StateModel.dart';
// import '../../data/models/resturant_model.dart';
// import '../entities/resturant_entity.dart';
// import '../repositories/restaurant_repo.dart';
//
// class SearchOnRestaurantUseCase
//     extends StateNotifier<StateModel<List<RestaurantEntity>>> {
//   final Ref ref;
//   final RestaurantRepo _restaurantRepo;
//
//   SearchOnRestaurantUseCase(this.ref, this._restaurantRepo)
//       : super(StateModel());
//
//   void call({
//     int? page = 0,
//     int? size = 10,
//     String? localeIsoCode = "en",
//     String? restaurantName,
//     String? cuisine,
//     String? restaurantPhone,
//     int? categoryId,
//     int? minRating,
//     bool? isOpen,
//   }) async {
//     state = StateModel(state: DataState.LOADING);
//
//     ResponseModel responseModel = await _restaurantRepo.searchOnRestaurant(
//       page: page,
//       size: size,
//       categoryId: categoryId,
//       cuisine: cuisine,
//       minRating: minRating,
//       isOpen: isOpen,
//       localeIsoCode: localeIsoCode,
//       restaurantName: restaurantName,
//       restaurantPhone: restaurantPhone,
//     );
//
//     if (responseModel.code == 200) {
//       var searchedRestaurantData = RestaurantModel.fromJson(responseModel.data);
//       print("this is Resturant Data $searchedRestaurantData");
//
//       // save user data
//
//       state = StateModel(
//           state: DataState.SUCCESS,
//           data: toRestaurantEntity(searchedRestaurantData),
//           message: responseModel.message);
//     } else {
//       state = StateModel(
//           state: DataState.ERROR,
//           message: responseModel.message,
//           errors: responseModel.errors);
//     }
//   }
// }
