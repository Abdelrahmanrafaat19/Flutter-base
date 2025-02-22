import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/widgets/app_text_field.dart';

class LabeledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int? errorMaxLine;
  final Widget label;
  final bool? isvisible;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool isvalidate;
  final FocusNode? focusNode;

  const LabeledTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.label,
    this.onChanged,
    this.isvisible = false,
    this.suffixIcon,
    this.validator,
    this.errorMaxLine,
    required this.isvalidate,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label,
        const SizedBox(height: 8),
        AppTextField(
          hintStyle: AppTheme.style14normalblack.copyWith(color: AppTheme.gray),
          hint: hint,
          focusNode: focusNode,
          borderRidus: BorderRadius.circular(8),
          secured: isvisible,
          textFieldColor:
              isvalidate == false ? const Color(0xffFFE5E5) : Colors.white,
          textFieldBorderColor: AppTheme.mainAppColor,
          textEditingController: controller,
          onChanged: onChanged,
          validate: validator,
          errorMaxLine: errorMaxLine,
        ),
      ],
    );
  }
}
