import 'package:flutter_base/core/Constants/Constants.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/widgets/svg_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double appBarHeight = 90.0;
  final String? title;
  final bool navigated;
  final Widget? trailingWidget;
  final BuildContext appContext;
  final bool isCenter;
  final VoidCallback? customCallBack;
  final Color? appBarColor;
  final Widget? leadingWidget;
  final bool isHomeScreen;
  const CustomAppBar(
      {Key? key,
      this.trailingWidget,
      this.title,
      this.navigated = false,
      required this.appContext,
      this.customCallBack,
      this.isCenter = false,
      this.appBarColor,
      this.leadingWidget,
      this.isHomeScreen = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return AppBar(
      toolbarHeight: leadingHeightCount(),
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: appBarColor ?? AppTheme.mainBackgroundLightColor,
      centerTitle: isCenter,
      actions: trailingWidget != null ? [trailingWidget!] : [],
      leadingWidth: 50,
      leading: leadingWidget ??
          (navigated
              ? InkWell(
                  onTap: () {
                    if (customCallBack != null) {
                      customCallBack?.call();
                      return;
                    }

                    try {
                      GoRouter.of(appContext).pop(appContext);
                    } catch (e) {
                      Navigator.pop(context);
                    }
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: defaultPaddingHorizontal,
                      ),
                      SVGIcons.localSVG(backIconPath, width: 32, height: 32),
                    ],
                  ))
              : const SizedBox()),
      title: Text(
        title ?? "",
        textAlign: TextAlign.center,
        style: themeData.textTheme.displayLarge?.copyWith(fontSize: 20),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  double? leadingHeightCount() {
    if (isHomeScreen) {
      return 100;
    }
    return null;
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
