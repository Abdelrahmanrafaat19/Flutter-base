import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/home/data/item_selector.dart';
import '../models/ResponseModel.dart';

typedef FutureResponseModel = Future<ResponseModel>;


// call backs
typedef VoidCallback = Function();
typedef FilterSelectCallBack = Function(int?);
typedef FilterDeleteItemCallBack = Function(FilterItemSelector?);
typedef FilterResult = Function(int?, int?,int?,RangeValues?);


// paginatedListView
typedef ItemBuilder<T> = Widget Function(T item);
typedef OnRefreshScreen = Function();