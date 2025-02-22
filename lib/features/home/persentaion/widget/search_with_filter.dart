import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/constants.dart';

import '../../../../core/Theme/app_theme.dart';
import '../../../../core/widgets/svg_icons.dart';

typedef OnTextChangeListener = Function(String);

class AppSearchBarWithFilter extends StatefulWidget {
  final int? delay;
  final bool hasFilter;
  final VoidCallback? onFilterClick;
  final VoidCallback? onSearchClick;
  final OnTextChangeListener? onTextChangeListener;
  final TextEditingController? controller;
  final bool? enableSearch;
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
      this.postIcon});

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
                        labelStyle:
                            AppTheme.styleWithTextAppGrey4RegularFonts14w400,
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaultButtonRadius),
                            borderSide: BorderSide(color: AppTheme.appGrey6)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaultButtonRadius),
                            borderSide: BorderSide(color: AppTheme.appGrey6)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(defaultButtonRadius),
                            borderSide: BorderSide(color: AppTheme.appGrey6)),
                        prefixIcon: SVGIcons.searchIcon()),
                    onChanged: (value) {
                      executeAfterDelay(value);
                    },
                  ),
                )
              : TextField(
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
                          AppTheme.styleWithTextAppGrey4RegularFonts14w400,
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(defaultButtonRadius),
                          borderSide: BorderSide(color: AppTheme.appGrey6)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(defaultButtonRadius),
                          borderSide: BorderSide(color: AppTheme.appGrey6)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(defaultButtonRadius),
                          borderSide: BorderSide(color: AppTheme.appGrey6)),
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
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppTheme.mainAppColorLight2,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  // child: Center(
                  //   child: SVGIcons.filterIcon(),
                  // ),
                ),
              )
            : SizedBox()
      ],
    );
  }
}
