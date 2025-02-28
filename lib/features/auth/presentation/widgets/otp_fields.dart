import 'package:flutter_base/core/Constants/Constants.dart';
import 'package:flutter_base/features/auth/presentation/providers/auth_enable_btu_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../../core/Theme/app_theme.dart';

class OTPFields extends ConsumerStatefulWidget {
  const OTPFields({super.key});

  @override
  ConsumerState<OTPFields> createState() => OTPFieldsState();
}

class OTPFieldsState extends ConsumerState<OTPFields> {
  final formKey = GlobalKey<FormState>();
  final otp1 = TextEditingController();
  final otp2 = TextEditingController();
  final otp3 = TextEditingController();
  final otp4 = TextEditingController();

  late FocusNode firstFocusNode;
  late FocusNode secondFocusNode;
  late FocusNode thirdFocusNode;
  late FocusNode fourthFocusNode;

  @override
  void initState() {
    firstFocusNode = FocusNode();
    secondFocusNode = FocusNode();
    thirdFocusNode = FocusNode();
    fourthFocusNode = FocusNode();
    // Add listeners to detect OTP changes
    for (var controller in [otp1, otp2, otp3, otp4]) {
      controller.addListener(_updateButtonState);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: otp1,
                focusNode: firstFocusNode,
                textAlign: TextAlign.center,
                cursorColor: AppTheme.mainAppColor,
                style: AppTheme.styleWithTextBlackAdelleSansExtendedFonts20w700,
                maxLength: 1,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    FocusScope.of(context).requestFocus(secondFocusNode);
                  }
                },
                decoration: InputDecoration(
                    counter: const SizedBox(),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppTheme.gray),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppTheme.mainAppColor,
                          width: 2.0), // Focused state
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppTheme.gray, width: 2.0),
                        borderRadius:
                            BorderRadius.circular(defaultButtonRadius)),
                    hintText: "-"),
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: otp2,
                focusNode: secondFocusNode,
                cursorColor: AppTheme.mainAppColor,
                textAlign: TextAlign.center,
                style: AppTheme.styleWithTextBlackAdelleSansExtendedFonts20w700,
                maxLength: 1,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    FocusScope.of(context).requestFocus(thirdFocusNode);
                  } else {
                    FocusScope.of(context).requestFocus(firstFocusNode);
                  }
                },
                decoration: InputDecoration(
                    counter: const SizedBox(),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppTheme.gray),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppTheme.mainAppColor,
                          width: 2.0), // Focused state
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppTheme.gray, width: 2.0),
                        borderRadius:
                            BorderRadius.circular(defaultButtonRadius)),
                    hintText: "-"),
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: otp3,
                focusNode: thirdFocusNode,
                cursorColor: AppTheme.mainAppColor,
                textAlign: TextAlign.center,
                style: AppTheme.styleWithTextBlackAdelleSansExtendedFonts20w700,
                maxLength: 1,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    FocusScope.of(context).requestFocus(fourthFocusNode);
                  } else {
                    FocusScope.of(context).requestFocus(secondFocusNode);
                  }
                },
                decoration: InputDecoration(
                    counter: const SizedBox(),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppTheme.gray),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppTheme.mainAppColor,
                          width: 2.0), // Focused state
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppTheme.gray, width: 2.0),
                        borderRadius:
                            BorderRadius.circular(defaultButtonRadius)),
                    hintText: "-"),
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: otp4,
                focusNode: fourthFocusNode,
                textAlign: TextAlign.center,
                cursorColor: AppTheme.mainAppColor,
                style: AppTheme.styleWithTextBlackAdelleSansExtendedFonts20w700,
                maxLength: 1,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isEmpty) {
                    FocusScope.of(context).requestFocus(thirdFocusNode);
                  }
                },
                decoration: InputDecoration(
                    counter: const SizedBox(),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppTheme.gray),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppTheme.mainAppColor,
                          width: 2.0), // Focused state
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppTheme.gray, width: 2.0),
                        borderRadius:
                            BorderRadius.circular(defaultButtonRadius)),
                    hintText: "-"),
              ),
            ),
          ),
          const SizedBox(width: 15)
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in [otp1, otp2, otp3, otp4]) {
      controller.dispose();
    }
    super.dispose();
  }

  String get getCode => [otp1, otp2, otp3, otp4].map((e) => e.text).join("");

  void _updateButtonState() {
    bool allFull = [otp1, otp2, otp3, otp4].every((c) => c.text.length == 1);
    ref.read(otpProvider.notifier).updateStatue(allFull);
  }
}
