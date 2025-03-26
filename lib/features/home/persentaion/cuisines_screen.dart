import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/widgets/custom_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/Constants/Constants.dart';
import '../../../core/constants/app_routes.dart';
import '../../../core/localization/Keys.dart';
import '../../../core/widgets/circle_image.dart';
import '../domain/entities/cuisine_entity.dart';
import 'Providers/usecase_provider.dart';
import 'widget/category_widgets/restaurant_category.dart';
class CuisinesScreen extends ConsumerStatefulWidget {
  const CuisinesScreen({super.key});

  @override
  ConsumerState<CuisinesScreen> createState() => _CuisinesScreenState();
}

class _CuisinesScreenState extends ConsumerState<CuisinesScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      if (ref.watch(fetchAllCuisinesStateNotifierProvider).data == null) {
        ref.read(fetchAllCuisinesStateNotifierProvider.notifier).call(
            page: "0",
            size: "1000",
            localeIsoCode: /*ref.watch(langProvider).toString()*/ "en",
            featured: true,
            fetchRestaurants: false,
            cuisineIds: []);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final cuisines = ref.watch(fetchAllCuisinesStateNotifierProvider);
    return Scaffold(
      appBar: CustomAppBar(
        navigated: true,
        appContext: context,
        title: context.tr(cuisinesKey),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GridView.builder(
          itemCount: cuisines.data?.length ?? 0,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 9,
              mainAxisSpacing: MediaQuery.of(context).size.height * 0.0379,
              childAspectRatio: 2 / 1.7),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                navigateToCuisineRestaurants(cuisines.data?[index]);
              },
              child: CuisineCard(
                width: double.infinity,
                height: double.infinity,
                categoryImg: cuisines.data?[index].image,
                categoryName: cuisines.data?[index].name,
              ),
            );
          },
        ),
      ),
    );
  }
  void navigateToCuisineRestaurants(Cuisine? cuisine) {
    context.push(seeAllScreenForCategoryRoute, extra: {
      TITLE_KEY: cuisine?.name,
      CUISINE_ID_KEY: cuisine?.id,
    });
  }
}
