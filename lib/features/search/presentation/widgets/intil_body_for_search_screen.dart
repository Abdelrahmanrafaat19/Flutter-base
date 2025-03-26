// features/search/presentation/widgets/intil_body_for_search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/Constants/Constants.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/eunms.dart';

import '../../../home/persentaion/Providers/filter_state_notifiers.dart';
import '../../../home/persentaion/bottom_sheets/filter_bottom_sheet.dart';
import '../../../home/persentaion/widget/filter/horizontal_filter_result_listview.dart';
import '../screens/search_result_screen.dart';
import 'search_item_list_initil_body.dart';

// ignore: must_be_immutable
class IntilBodyForSearchScreen extends ConsumerStatefulWidget {
  final List<dynamic> data;

  const IntilBodyForSearchScreen({super.key, required this.data});

  @override
  ConsumerState<IntilBodyForSearchScreen> createState() =>
      _IntilBodyForSearchScreenState();
}

class _IntilBodyForSearchScreenState
    extends ConsumerState<IntilBodyForSearchScreen> {


  @override
  Widget build(BuildContext context) {
    var filterResult = ref.watch(restaurantFilterProvider);
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              filterResult.clear();

              context.push(
                allDataOfSearchCategoryRoute,
                extra: widget.data[index]["title"],
              );
            },
            child: SearchItemListInitilBody(
              listLength: widget.data.length,
              index: index,
              title: widget.data[index]["title"],
              iconPath: widget.data[index]["iconPath"],
              hasSubTitle: widget.data[index]["hasSubTitle"],
              subTitle: widget.data[index]["subTitle"],
            ),
          );
        },
      ),
    );
  }


}
