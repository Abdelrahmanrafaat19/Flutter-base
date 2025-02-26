import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/Constants/Constants.dart';
import '../../../../../core/Theme/app_theme.dart';
import '../../../../../core/utils/typedefs.dart';

class ResultFilterItem extends StatelessWidget {
  final String optionName;
  final Widget? icon;
  final int? id;
  final FilterSelectCallBack onItemDelete;
  const ResultFilterItem(
      {super.key,
      required this.optionName,
      this.icon,
      this.id,
      required this.onItemDelete});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemDelete.call(id);
      },
      child: Container(
        height: 50,
        width: 110,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultButtonRadius),
            color: AppTheme.filterOptionBackground),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null ? icon! : const SizedBox(),
            SizedBox(
              width: icon != null ? 5 : 0,
            ),
            Text(
              optionName,
              style: AppTheme.styleWithTextBlackSmRegularFonts14w400
                  .copyWith(color: AppTheme.filterOptionTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
