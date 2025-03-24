import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/features/home/domain/entities/category_entity.dart';
import 'package:flutter_base/features/home/domain/entities/cuisine_entity.dart';
import 'package:flutter_base/features/home/domain/entities/restaurant_entity.dart';
import 'package:flutter_base/features/notification/domain/entities/notification_entity.dart';

import '../../features/home/data/models/item_selector.dart';
import '../models/ResponseModel.dart';

typedef FutureResponseModel = Future<ResponseModel>;


// call backs
typedef VoidCallback = Function();
typedef FilterSelectCallBack = Function(int?);
typedef FilterDeleteItemCallBack = Function(FilterItemSelector?);
typedef FilterResult = Function(int?, int?,int?,RangeValues?);
typedef OnNotificationClick = Function(NotificationEntity);
typedef OnSeeAllCategoryClick = Function(CategoryEntity);
typedef OnRestaurantClick = Function(Restaurant?);
typedef OnCuisineItemClick = Function(Cuisine);

// paginatedListView
typedef ItemBuilder<T> = Widget Function(T item);
typedef OnRefreshScreen = Function();