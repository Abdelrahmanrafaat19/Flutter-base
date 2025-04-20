import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/features/restaurant_details/presentation/widgets/meal_item.dart';

import '../../../../core/Theme/app_theme.dart';

class CategoryTabContent extends StatelessWidget {
  final int index;
  CategoryTabContent({super.key, required this.index});

  // مثال تجريبي - تقدر تغيره ببيانات حقيقية حسب الكاتيجوري
  List<Map<String, dynamic>> meals = [
    {
      'title': 'Original Mushroom Burger',
      'desc': 'A premium burger with mushroom and sauce.',
      'price': 40.99,
    },
    {
      'title': 'Classic Cheeseburger',
      'desc': 'Cheesy, juicy, and classic!',
      'price': 45.99,
    },
  ];
  List<Map<String, dynamic>> meals2 = [
    {
      'title': 'Original Mushroom Burger',
      'desc': 'A premium burger with mushroom and sauce.',
      'price': 40.99,
    },
    {
      'title': 'Original Mushroom Burger',
      'desc': 'A premium burger with mushroom and sauce.',
      'price': 40.99,
    },
    {
      'title': 'Classic Cheeseburger',
      'desc': 'Cheesy, juicy, and classic!',
      'price': 45.99,
    },
    {
      'title': 'Original Mushroom Burger',
      'desc': 'A premium burger with mushroom and sauce.',
      'price': 40.99,
    },
    {
      'title': 'Original Mushroom Burger',
      'desc': 'A premium burger with mushroom and sauce.',
      'price': 40.99,
    },
    {
      'title': 'Classic Cheeseburger',
      'desc': 'Cheesy, juicy, and classic!',
      'price': 45.99,
    },
    {
      'title': 'Original Mushroom Burger',
      'desc': 'A premium burger with mushroom and sauce.',
      'price': 40.99,
    },
    {
      'title': 'Original Mushroom Burger',
      'desc': 'A premium burger with mushroom and sauce.',
      'price': 40.99,
    },
    {
      'title': 'Classic Cheeseburger',
      'desc': 'Cheesy, juicy, and classic!',
      'price': 45.99,
    },
    {
      'title': 'Original Mushroom Burger',
      'desc': 'A premium burger with mushroom and sauce.',
      'price': 40.99,
    },
    {
      'title': 'Original Mushroom Burger',
      'desc': 'A premium burger with mushroom and sauce.',
      'price': 40.99,
    },
    {
      'title': 'Classic Cheeseburger',
      'desc': 'Cheesy, juicy, and classic!',
      'price': 45.99,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(), // عشان ما يحصلش conflict مع CustomScrollView
      shrinkWrap: true, // مهم جدًا داخل SliverToBoxAdapter
      itemCount:index == 0 ? meals.length : meals2.length,
      itemBuilder: (context, i) {
        final meal = index == 0 ? meals[i] : meals2[i];
        return MealItem();
      },
     separatorBuilder: (context ,index) => const Divider(
       height: 1,
       color: AppTheme.gray,
     ),
    );
  }
}
