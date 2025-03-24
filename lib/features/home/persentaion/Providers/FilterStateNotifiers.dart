import 'package:flutter_base/features/home/data/item_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterStateNotifiers extends StateNotifier<List<FilterItemSelector>>{
  FilterStateNotifiers() : super([]);

  void updateStatue(List<FilterItemSelector> newState) async {
    state = newState;
  }

  void deleteItem(FilterItemSelector item) async {
    List<FilterItemSelector> items = state;
    items.remove(item);
    state = [...items];
  }

}


final restaurantFilterProvider = StateNotifierProvider.autoDispose<FilterStateNotifiers, List<FilterItemSelector>>((ref) {
  return FilterStateNotifiers();
});
// final restaurantDistantFilterProvider = StateNotifierProvider.autoDispose<FilterStateNotifiers, List<FilterItemSelector>>((ref) {
//   return FilterStateNotifiers();
// });
