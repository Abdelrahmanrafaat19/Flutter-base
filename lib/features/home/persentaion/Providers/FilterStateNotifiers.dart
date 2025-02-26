import 'package:flutter_base/features/home/data/item_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterStateNotifiers extends StateNotifier<List<ItemSelector>>{
  FilterStateNotifiers() : super([]);

  void updateStatue(List<ItemSelector> newState) async {
    state = newState;
  }

}


final restaurantFilterProvider = StateNotifierProvider.autoDispose<FilterStateNotifiers, List<ItemSelector>>((ref) {
  return FilterStateNotifiers();
});
