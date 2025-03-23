import 'package:flutter_base/features/home/domain/repositories/home_repository.dart';
import '../../../../core/utils/typedefs.dart';
import '../../data/data_sources/data_sources.dart';

class HomeRepositoryImp extends HomeRepository {
  final HomeRemoteDataSource _dataSource;

  HomeRepositoryImp(this._dataSource);

  @override
  FutureResponseModel fetchCategories(
      {String? page,
      String? size,
      String? localeIsoCode,
      bool? fetchRestaurants,
      bool? featured,
      List<int>? categoryIds}) {
    return _dataSource.fetchCategories(
      page: page,
      size: size,
      localeIsoCode: localeIsoCode,
      featured: featured,
      fetchRestaurants: fetchRestaurants,
      categoryIds: categoryIds
    );
  }

  @override
  FutureResponseModel fetchCuisines(
      {String? page,
      String? size,
      String? localeIsoCode,
      bool? fetchRestaurants,
      bool? featured,
      List<int>? categoryIds}) {
    return _dataSource.fetchCuisines(
        page: page,
        size: size,
        localeIsoCode: localeIsoCode,
        featured: featured,
        fetchRestaurants: fetchRestaurants,
        categoryIds: categoryIds
    );
  }
}
