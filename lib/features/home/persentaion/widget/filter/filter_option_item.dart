import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Constants/Constants.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';

import '../../../../../core/utils/typedefs.dart';

class FilterOptionItem extends StatefulWidget {
  final bool state;
  final String optionName;
  final Widget? icon;
  final int? id;
  final FilterSelectCallBack onItemSelect;
  const FilterOptionItem(
      {super.key,
      this.state = false,
      required this.optionName,
      required this.onItemSelect,
      required this.id,
      this.icon});

  @override
  State<FilterOptionItem> createState() => _FilterOptionItemState();
}

class _FilterOptionItemState extends State<FilterOptionItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onItemSelect.call(widget.id);
      },
      child: Container(
        height: 50,
        width: 110,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultButtonRadius),
            color: widget.state ? AppTheme.orangeAppColor : Colors.white,
            border: widget.state
                ? const Border()
                : Border.all(width: 1, color: AppTheme.appGrey8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon != null ? widget.icon! : const SizedBox(),
            SizedBox(
              width: widget.icon != null ? 5 : 0,
            ),
            Text(
              widget.optionName,
              style: AppTheme.styleWithTextBlackSmRegularFonts14w400
                  .copyWith(color: widget.state ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
