import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/widgets/border_styles.dart';
import 'package:flutter_base/core/widgets/border_styles.dart';

import '../constants/constants.dart';

typedef StringCallBack = Function(String);

class AppTextField extends StatefulWidget {
  final bool? readOnly;
  final String hint;
  final TextStyle? hintStyle;
  final Widget? label;
  final StringCallBack? value;
  final StringCallBack? changeValueCallback;
  final TextEditingController textEditingController;
  final FocusNode? focusNode;
  final double? width;
  final BorderRadius? borderRidus;
  final Color? textFieldColor;
  final Color? textFieldBorderColor;
  final Color? textFieldEnableBorderColor;
  final TextInputType? textInputType;
  final bool? secured;
  final int? minLines;
  final int? maxLines;
  final int? maxLen;
  final int? errorMaxLine;
  final bool? disabled;
  final VoidCallback? onClick;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final String? endText;
  final String? Function(String?)? validate;
  final TextInputFormatter? mask;
  final AutovalidateMode? mode;
  final Widget? endWidget;
  final Widget? startWidget;
  void Function(String)? onChanged;
  AppTextField({
    Key? key,
    required this.hint,
    this.borderRidus,
    this.secured = false,
    this.textInputType,
    this.onChanged,
    this.width,
    this.label,
    this.value,
    this.style,
    this.minLines,
    this.maxLines,
    this.maxLen,
    this.changeValueCallback,
    this.mask,
    required this.textEditingController,
    this.textFieldColor,
    this.textInputAction,
    this.textFieldBorderColor,
    this.disabled,
    this.onClick,
    this.endText,
    this.validate,
    this.mode,
    this.readOnly = false,
    this.endWidget,
    this.startWidget,
    this.hintStyle,
    this.textFieldEnableBorderColor,
    this.errorMaxLine,
    this.focusNode,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _visiblePassword = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        width: widget.width,
        child: TextFormField(
            focusNode: widget.focusNode,
            readOnly: widget.readOnly ?? false,
            autovalidateMode: widget.mode,
            inputFormatters: widget.mask != null ? [widget.mask!] : null,
            onTapOutside: (val) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            keyboardType: widget.textInputType,
            textInputAction: widget.textInputAction,
            controller: widget.textEditingController,
            textAlign:
                widget.maxLen != null ? TextAlign.center : TextAlign.start,
            obscureText: (!_visiblePassword && widget.secured!),
            onChanged: widget.onChanged ??
                (val) {
                  if (widget.changeValueCallback != null) {
                    widget.changeValueCallback!(val);
                  }
                },
            validator: widget.validate,
            minLines: widget.minLines,
            maxLength: widget.maxLen,
            maxLines: widget.secured == true ? 1 : widget.maxLines,
            onFieldSubmitted: (val) => widget.value!(val),
            style: widget.style ??
                TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    fontSize: 16),
            decoration: InputDecoration(
                contentPadding: defaultPaddingForInputFields,
                errorMaxLines: widget.errorMaxLine,
                label: widget.label,
                suffixText: widget.endText,
                hintText: widget.hint,
                hintStyle: widget.hintStyle,
                prefixIcon: widget.startWidget,
                suffixIcon: widget.secured!
                    ? IconButton(
                        onPressed: () => setState(
                            () => _visiblePassword = !_visiblePassword),
                        icon: Icon(_visiblePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        color: Colors.grey,
                      )
                    : widget.endWidget,
                labelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w100,
                    color: Theme.of(context).textTheme.bodyMedium!.color),
                focusedBorder: AppBorders.getBorder(
                    borderColor:
                        widget.textFieldBorderColor ?? AppTheme.mainAppColor),
                errorBorder: AppBorders.getErrorBorder(
                    radius: widget.borderRidus ?? BorderRadius.circular(4)),
                focusedErrorBorder: AppBorders.getErrorBorder(
                    radius: widget.borderRidus ?? BorderRadius.circular(4)),
                enabledBorder: AppBorders.getEnableBorder(),
                disabledBorder: AppBorders.getBorder(
                    borderColor:
                        widget.textFieldEnableBorderColor ?? AppTheme.appGrey8),
                filled: true,
                counter: SizedBox(),
                enabled: widget.disabled != null ? (!widget.disabled!) : true,
                fillColor: widget.textFieldColor ??
                    themeData.appBarTheme.backgroundColor)),
      ),
    );
  }

  // InputBorder get getBorder => widget.textFieldBorderColor != null
  //     ? OutlineInputBorder(
  //         borderSide:
  //             BorderSide(color: widget.textFieldBorderColor ?? Colors.blue),
  //         borderRadius: widget.borderRidus ?? BorderRadius.circular(4),
  //       )
  //     : UnderlineInputBorder(
  //         borderSide: BorderSide(color: Colors.transparent),
  //         borderRadius: widget.borderRidus ?? BorderRadius.circular(4),
  //       );
  // InputBorder get getEnbleBorder => widget.textFieldBorderColor != null
  //     ? OutlineInputBorder(
  //         borderSide: BorderSide(
  //             color: widget.textFieldEnableBorderColor ?? AppTheme.appGrey8),
  //         borderRadius: widget.borderRidus ?? BorderRadius.circular(4),
  //       )
  //     : UnderlineInputBorder(
  //         borderSide: BorderSide(color: Colors.transparent),
  //         borderRadius: widget.borderRidus ?? BorderRadius.circular(4),
  //       );
  // InputBorder get getErrBorder => widget.textFieldBorderColor != null
  //     ? OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.red),
  //         borderRadius: widget.borderRidus ?? BorderRadius.circular(4),
  //       )
  //     : UnderlineInputBorder(
  //         borderSide: BorderSide(color: Colors.transparent),
  //         borderRadius: widget.borderRidus ?? BorderRadius.circular(4),
  //       );
}
