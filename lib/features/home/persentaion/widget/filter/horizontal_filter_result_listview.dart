import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_base/features/home/persentaion/widget/filter/result_filter_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/typedefs.dart';
import '../../../data/item_selector.dart';

class HorizontalFilterResultListview extends StatefulWidget {
  final List<FilterItemSelector> list;
  final FilterDeleteItemCallBack onItemDelete;

  const HorizontalFilterResultListview(
      {super.key, required this.list, required this.onItemDelete});

  @override
  State<HorizontalFilterResultListview> createState() =>
      _HorizontalFilterResultListviewState();
}

class _HorizontalFilterResultListviewState
    extends State<HorizontalFilterResultListview> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: ResultFilterItem(
                optionName: widget.list[index].name ?? "",
                icon: widget.list[index].image?.isNotEmpty == true
                    ? SVGIcons.localSVG(widget.list[index].image!,
                        width: 16,
                        height: 16,
                        color: AppTheme.filterOptionTextColor)
                    : null,
                id: widget.list[index].id,
                onItemDelete: (id) {
                  widget.onItemDelete.call(widget.list[index]);
                },
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
                width: 0,
              ),
          itemCount: widget.list.length),
    );
  }
}
