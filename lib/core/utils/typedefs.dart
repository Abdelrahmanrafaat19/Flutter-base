import 'package:flutter/cupertino.dart';

import '../models/ResponseModel.dart';

typedef FutureResponseModel = Future<ResponseModel>;


// call backs
typedef VoidCallback = Function();
typedef FilterSelectCallBack = Function(int?);

// paginatedListView
typedef ItemBuilder<T> = Widget Function(T item);
typedef OnRefreshScreen = Function();