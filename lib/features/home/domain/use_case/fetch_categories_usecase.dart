import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base/features/home/domain/entities/category_entity.dart';
import 'package:flutter_base/features/home/domain/repositories/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/ResponseModel.dart';
import '../../../../core/models/StateModel.dart';
import '../../data/models/category_model.dart';

class FetchCategoriesUseCase extends StateNotifier<StateModel<List<CategoryEntity>>> {
  final Ref ref;
  final HomeRepository _homeRepository;
  FetchCategoriesUseCase(this.ref, this._homeRepository) : super(StateModel());

  void call({
    String? page = "0",
    String? size = "10",
    String? localeIsoCode = "en",
    bool? fetchRestaurants = true,
    bool? featured = true,
    List<int>? categoryIds,
  })
  async {
    state = StateModel.loading();

    ResponseModel responseModel = await _homeRepository.fetchCategories(
      page: page,
      size: size,
      localeIsoCode: localeIsoCode,
      fetchRestaurants: fetchRestaurants,
      featured: featured,
    );

    if (responseModel.code == 200) {
      List<CategoryEntity> categories= (responseModel.data as List)
      .map((item) => toCategoryEntity(CategoryModel.fromJson(item))).toList();
      state = StateModel(
          state: DataState.SUCCESS, data: categories, message: responseModel.message);
    } else {
      state = StateModel(
          state: DataState.ERROR,
          message: responseModel.message,
          errors: responseModel.errors);
    }
  }
}
