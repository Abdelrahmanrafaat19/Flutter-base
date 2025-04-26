// import 'package:flutter_base/features/search/data/models/resturant_model.dart';
// import 'package:flutter_base/features/search/domain/entities/resturant_entity.dart';
// import 'package:flutter_base/features/search/domain/repositories/restaurant_repo.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../../core/models/ResponseModel.dart';
// import '../../../../core/models/StateModel.dart';
//
// class FetchRestaurantDataUseCase extends StateNotifier<StateModel<List<RestaurantEntity>>>{
//   final Ref ref;
//   final RestaurantRepo _restaurantRepo;
//   FetchRestaurantDataUseCase(this.ref,this._restaurantRepo): super(StateModel());
//    void call({int? page=0, int? size=10}) async {
//     state = StateModel(state: DataState.LOADING);
//
//     ResponseModel responseModel = await _restaurantRepo.fetchAllRestaurantData(
//         page: page, size: size
//     );
//
//     if (responseModel.code == 200) {
//       var resturantData = RestaurantModel.fromJson(responseModel.data);
//       print("this is Resturant Data $resturantData");
//
//       // save user data
//
//
//       state = StateModel(
//           state: DataState.SUCCESS,
//           data: toRestaurantEntity(resturantData),
//           message: responseModel.message);
//     } else {
//       state = StateModel(
//           state: DataState.ERROR,
//           message: responseModel.message,
//           errors: responseModel.errors);
//     }
//   }
//
// }