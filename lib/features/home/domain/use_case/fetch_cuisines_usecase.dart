import 'package:flutter/cupertino.dart';
import 'package:flutter_base/features/home/data/models/cuisine_model.dart';
import 'package:flutter_base/features/home/domain/entities/cuisine_entity.dart';
import 'package:flutter_base/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/ResponseModel.dart';
import '../../../../core/models/StateModel.dart';

class FetchCuisinesUseCase extends StateNotifier<StateModel<List<Cuisine>>> {
  final Ref ref;
  final HomeRepository _homeRepository;
  FetchCuisinesUseCase(this.ref, this._homeRepository) : super(StateModel());

  void call({
    String? page = "0",
    String? size = "1",
    String? localeIsoCode = "en",
    bool? fetchRestaurants = false,
    bool? featured = false,
    List<int>? categoryIds,
  })
  async {
    state = StateModel.loading();

    ResponseModel responseModel = await _homeRepository.fetchCuisines(
      page: page,
      size: size,
      localeIsoCode: localeIsoCode,
      fetchRestaurants: fetchRestaurants,
      featured: featured,
      categoryIds: categoryIds ?? []
    );

    if (responseModel.code == 200) {
      List<Cuisine> cuisines = (responseModel.data as List)
      .map((item) => toCuisineEntity(CuisineModel.fromJson(item))).toList();

      debugPrint("cuisinesCount : ${cuisines.first.name}");
      state = StateModel(
          state: DataState.SUCCESS, data: cuisines, message: responseModel.message);
    } else {
      state = StateModel(
          state: DataState.ERROR,
          message: responseModel.message,
          errors: responseModel.errors);
    }
  }
}
