import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import '../../../../../core/Constants/Constants.dart';
import '../../../../../core/Theme/app_theme.dart';
import '../../../../../core/constants/assets.dart';
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
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 8),
      child: Container(
        padding: const EdgeInsetsDirectional.symmetric(
            horizontal: defaultPaddingHorizontal),
        height: 32,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultButtonRadius),
            color: AppTheme.filterOptionBackground),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              optionName,
              style: AppTheme.styleWithTextBlackSmRegularFonts14w400
                  .copyWith(color: AppTheme.filterOptionTextColor),
            ),
            SizedBox(
              width: icon != null ? 5 : 0,
            ),
            icon != null ? icon! : const SizedBox(),
            const SizedBox(
              width: 5,
            ),
            InkWell(
                onTap: () {
                  onItemDelete.call(id);
                },
                child: SVGIcons.localSVG(deleteCircleIconPath,
                    width: 16, height: 16))
          ],
        ),
      ),
    );
  }
}
