// features/home/persentaion/widget/search_with_filter.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/constants.dart';

import '../../../../core/Theme/app_theme.dart';
import '../../../../core/widgets/border_styles.dart';
import '../../../../core/widgets/svg_icons.dart';

typedef OnTextChangeListener = Function(String);

class AppSearchBarWithFilter extends StatefulWidget {
  final int? delay;
  final bool hasFilter;
  final bool? hasBorder;
  final VoidCallback? onFilterClick;
  final VoidCallback? onSearchClick;
  final OnTextChangeListener? onTextChangeListener;
  final TextEditingController? controller;
  final bool? enableSearch;
  final Color filterIconColor;
  final String? hintTxt;
  final Widget? postIcon;
  const AppSearchBarWithFilter(
      {super.key,
      required this.hasFilter, this.onFilterClick,
      this.onTextChangeListener,
      this.delay,
      this.enableSearch = true,
      this.onSearchClick,
      this.controller,
      this.hintTxt,
      this.postIcon, this.hasBorder = true, required this.filterIconColor});

  @override
  State<AppSearchBarWithFilter> createState() => _AppSearchBarWithFilterState();
}

class _AppSearchBarWithFilterState extends State<AppSearchBarWithFilter> {
  final TextEditingController textEditingController = TextEditingController();
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when disposing the widget
    super.dispose();
  }

  void executeAfterDelay(value) {
    _timer?.cancel(); // Cancel previous timer if it exists

    _timer = Timer(Duration(seconds: widget.delay ?? 0), () {
      widget.onTextChangeListener?.call(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: widget.enableSearch == false
              ? InkWell(
                  onTap: () {
                    widget.onSearchClick?.call();
                  },
                  child: TextField(
                    controller: widget.controller,
                    readOnly: widget.enableSearch == false,
                    enabled: widget.enableSearch,
                    style: AppTheme
                        .styleWithTextBlackAdelleSansExtendedFonts14w400,

                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        labelText: widget.hintTxt,
                        suffixIcon: widget.postIcon,
                        hintStyle: AppTheme.style14normalblack.copyWith(color: AppTheme.appGrey10),
                        labelStyle:
                            AppTheme.styleWithTextAppGrey4RegularFonts14w400.copyWith(color: AppTheme.appGrey10),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(defaultButtonRadius),
                            borderSide: BorderSide(color: widget.hasBorder == true ? AppTheme.appGrey8 : Colors.white)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(defaultButtonRadius),
                            borderSide: BorderSide(color:widget.hasBorder == true ? AppTheme.appGrey8 : Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(defaultButtonRadius),
                            borderSide: BorderSide(color: widget.hasBorder == true ? AppTheme.appGrey8 : Colors.white)),
                        disabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(defaultButtonRadius),
                          borderSide: BorderSide(color: widget.hasBorder == true ? AppTheme.appGrey8 : Colors.white), // Disabled border color
                        ),
                        prefixIcon: SVGIcons.searchIcon()),
                    onChanged: (value) {
                      executeAfterDelay(value);
                    },
                  ),
                )
              : TextField(
                  cursorColor: AppTheme.mainAppColor,
                  controller: widget.controller,
                  readOnly: widget.enableSearch == false,
                  enabled: widget.enableSearch,
                  style:
                      AppTheme.styleWithTextBlackAdelleSansExtendedFonts14w400,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      labelText: widget.hintTxt,
                      labelStyle:
                          AppTheme.styleWithTextAppGrey4RegularFonts14w400.copyWith(color: AppTheme.appGrey10),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(defaultButtonRadius),
                          borderSide: BorderSide(color: widget.hasBorder == true ? AppTheme.appGrey8 : Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(defaultButtonRadius),
                          borderSide: BorderSide(color: widget.hasBorder == true ? AppTheme.appGrey8 : Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(defaultButtonRadius),
                          borderSide: BorderSide(color: widget.hasBorder == true ? AppTheme.appGrey8 : Colors.white)),
                      prefixIcon: SVGIcons.searchIcon()),
                  onChanged: (value) {
                    executeAfterDelay(value);
                  },
                ),
        ),
        widget.hasFilter
            ? SizedBox(
                width: 8,
              )
            : SizedBox(),
        widget.hasFilter
            ? InkWell(
                onTap: () {
                  widget.onFilterClick?.call();
                },
                child: Container(
                  width: 48,
                  height: 48,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border:
                    Border.all(color: AppTheme.appGrey8, width: 1),
                  ),
                  child: SVGIcons.localSVG(
                      "assets/images/filter_icon.svg",
                      width: 24,
                      height: 24,color: widget.filterIconColor),
                ),
              )
            : SizedBox()
      ],
    );
  }
}
