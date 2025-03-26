import 'package:flutter_base/features/home/domain/entities/category_entity.dart';
import 'package:flutter_base/features/home/domain/entities/cuisine_entity.dart';
import 'package:flutter_base/features/home/domain/providers/home_repository_provider.dart';
import '../../../../core/models/StateModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/use_case/fetch_categories_usecase.dart';
import '../../domain/use_case/fetch_cuisines_usecase.dart';

final fetchCuisinesStateNotifierProvider =
    StateNotifierProvider.autoDispose<FetchCuisinesUseCase, StateModel<List<Cuisine>>>(
        (ref) => FetchCuisinesUseCase(ref, ref.read(homeRepoProvider)));

final fetchAllCuisinesStateNotifierProvider =
    StateNotifierProvider<FetchCuisinesUseCase, StateModel<List<Cuisine>>>(
        (ref) => FetchCuisinesUseCase(ref, ref.read(homeRepoProvider)));

final fetchCategoriesStateNotifierProvider =
    StateNotifierProvider.autoDispose<FetchCategoriesUseCase, StateModel<List<CategoryEntity>>>(
        (ref) => FetchCategoriesUseCase(ref, ref.read(homeRepoProvider)));
