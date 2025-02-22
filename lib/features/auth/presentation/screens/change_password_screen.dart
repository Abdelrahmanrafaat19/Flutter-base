import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/Assets.dart';
import 'package:flutter_base/core/constants/constants.dart';
import 'package:flutter_base/core/localization/Keys.dart';
import 'package:flutter_base/core/widgets/app_button.dart';
import 'package:flutter_base/core/widgets/custom_app_bar.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_base/features/auth/presentation/widgets/auth_header_widget.dart';
import 'package:flutter_base/features/auth/presentation/widgets/labeled_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_validation_providers.dart';
import '../widgets/success_bottom_sheet.dart';

class ChangePassword extends ConsumerStatefulWidget {
  final String Phone;
  const ChangePassword({super.key, required this.Phone});

  @override
  ConsumerState<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  final formKey = GlobalKey<FormState>();
  bool isPasswordVisible = true;

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isNewPasswordValidate = true;
  bool isConfirmNewPasswordValidate = true;

  @override
  void initState() {
    // Add listeners to detect OTP changes
    for (var controller in [newPasswordController, confirmPasswordController]) {
      controller.addListener(_updateButtonState);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final changePasswordState = ref.watch(changePasswordProvider);

    return Scaffold(
        appBar: CustomAppBar(
          navigated: true,
          appContext: context,
          title: context.tr(changePasswordKey),
          trailingWidget: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPaddingHorizontal),
            child: Center(
              child: Text(
                "Arabic",
                style: AppTheme.styleWithTextBlackAdelleSansExtendedFonts16w400,
              ),
            ),
          ),
        ),
        body: Form(
          key: formKey,
          child: Container(
            height: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPaddingHorizontal),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AuthHeaderWidget(
                    marginTop: 36,
                    marginBottom: 64,
                  ),
                  LabeledTextField(
                    isvalidate: isNewPasswordValidate,
                    isvisible: isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppTheme.gray,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    controller: newPasswordController,
                    hint: /* context.tr(OldPasswordKey) */ ".......",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        isNewPasswordValidate = false;
                        return "New Password is required";
                      }
                      return null;
                    },
                    label: Text(
                      /* context.tr(OldPasswordKey) */ "New Password",
                      style: AppTheme.style14normalblack,
                    ),
                  ),
                  SizedBox(height: 16),
                  LabeledTextField(
                    isvalidate: isConfirmNewPasswordValidate,
                    isvisible: isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppTheme.gray,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        isConfirmNewPasswordValidate = false;
                        return "Confirem New Password is required";
                      } else if (value != newPasswordController.text) {
                        isConfirmNewPasswordValidate = false;

                        return "Passwords do not match";
                      }
                      return null;
                    },
                    controller: confirmPasswordController,
                    hint: /* context.tr(OldPasswordKey) */ ".......",
                    label: Text(
                      /* context.tr(OldPasswordKey) */ "Confirm New Password ",
                      style: AppTheme.style14normalblack,
                    ),
                  ),
                  SizedBox(height: 32),
                  AppButton(
                      enabled: changePasswordState,
                      width: double.infinity,
                      height: defaultButtonHeight,
                      backColor: AppTheme.mainAppColor,
                      text: "save",
                      onPress: () {
                        // showModalBottomSheet(
                        //   context: context,
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius:
                        //         BorderRadius.vertical(top: Radius.circular(20)),
                        //   ),
                        //   builder: (context) {
                        //     return PasswordResetBottomSheet();
                        //   },
                        // );
                        setState(() {});
                        if (formKey.currentState!.validate()) {
                          showSuccessBottomSheet();
                        }
                      }),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    for (var element in [newPasswordController, confirmPasswordController]) {
      element.dispose();
    }
    for (var controller in [newPasswordController, confirmPasswordController]) {
      controller.dispose();
    }
    super.dispose();
  }

  String get getCode => [newPasswordController, confirmPasswordController]
      .map((e) => e.text)
      .join("");

  void _updateButtonState() {
    bool allFull = [newPasswordController, confirmPasswordController]
        .every((c) => c.text.isNotEmpty);
    ref.read(changePasswordProvider.notifier).updateStatue(allFull);
  }

  void showSuccessBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10))),
        context: context,
        builder: (BuildContext context) => SuccessBottomSheet(
              imageWidget: SVGIcons.localImage(successAnimation,
                  width: 100, height: 100),
              title: "Password Reset Successfully",
              description: "Your password has been updated",
              btnName: "Save",
              clickAction: () {},
            ));
  }
}
