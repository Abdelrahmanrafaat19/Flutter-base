import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_base/features/auth/presentation/widgets/intl_phone_field.dart';
import 'package:flutter_base/features/auth/presentation/widgets/phone_number.dart';

import '../../../../core/widgets/border_styles.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(PhoneNumber)? onChanged;
  final String? Function(String?)? validator;
  final bool isPhoneNumberIsValidate;
  const PhoneNumberField(
      {super.key,
      this.controller,
      this.onChanged,
      this.validator,
      required this.isPhoneNumberIsValidate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Phone Number",
          style: AppTheme.style14BoldBlack,
        ),
        SizedBox(height: 8),
        IntlPhoneField(
          cursorColor: AppTheme.mainAppColor,
          dropdownTextStyle: AppTheme.fontStyle16color333740,
          dropdownIcon: SVGIcons.localSVG(
            "assets/images/arrowdown.svg",
            width: 20,
            height: 20,
          ),
          decoration: InputDecoration(
            fillColor: isPhoneNumberIsValidate == false
                ? const Color(0xffFFE5E5)
                : Colors.white,
            filled: true,
            hintText: "Enter phone number",
            focusedBorder:
                AppBorders.getBorder(borderColor: AppTheme.mainAppColor),
            errorBorder: AppBorders.getErrorBorder(),
            focusedErrorBorder: AppBorders.getErrorBorder(),
            enabledBorder: AppBorders.getEnableBorder(),
            disabledBorder: AppBorders.getBorder(),
          ),
          initialCountryCode: 'US', // Set the default country
          onChanged: onChanged,
          controller: controller,
          validator: validator,
        ),
      ],
    );
  }
}
