import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/features/home/persentaion/widget/filter/result_filter_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../data/item_selector.dart';

class HorizontalFilterResultListview extends StatefulWidget {
  final List<ItemSelector> list;
  const HorizontalFilterResultListview({super.key, required this.list});

  @override
  State<HorizontalFilterResultListview> createState() => _HorizontalFilterResultListviewState();
}

class _HorizontalFilterResultListviewState extends State<HorizontalFilterResultListview> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){

              },
              child: ResultFilterItem(
                optionName: widget.list[index].name ?? "",
                id: widget.list[index].id, onItemDelete: (id) {

              },
              ),
            );
          },
          separatorBuilder: (context , index) => const SizedBox(
            width: 12,
          ),
          itemCount: widget.list.length),
    );
  }
}
