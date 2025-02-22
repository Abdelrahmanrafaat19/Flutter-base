import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/constants.dart';
import 'package:flutter_base/core/localization/Keys.dart';
import 'package:flutter_base/core/widgets/custom_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/widgets/app_button.dart';
import '../providers/auth_validation_providers.dart';
import '../widgets/auth_header_widget.dart';
import '../widgets/phone_number_field.dart';

class ForgetPasswordScreen extends ConsumerStatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  ConsumerState<ForgetPasswordScreen> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends ConsumerState<ForgetPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  bool isPhoneNumberIsValidate = true;

  @override
  void initState() {
    super.initState();
    phoneController.addListener(_updateButtonState);
  }

  @override
  Widget build(BuildContext context) {
    final forgetPasswordState = ref.watch(forgetPasswordProvider);
    return Scaffold(
      appBar: CustomAppBar(
        navigated: true,
        appContext: context,
        title: context.tr(forgetPasswordKey),
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
          padding:
              const EdgeInsets.symmetric(horizontal: defaultPaddingHorizontal),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 25),
                AuthHeaderWidget(
                  marginTop: 36,
                  marginBottom: 64,
                ),
                SizedBox(height: 25),
                PhoneNumberField(
                  isPhoneNumberIsValidate: isPhoneNumberIsValidate,
                  controller: phoneController,
                  validator: (phone) {
                    if (phone == null || phone.isEmpty) {
                      isPhoneNumberIsValidate = false;
                      return 'Phone number is required';
                    }

                    final RegExp phoneRegExp = RegExp(r"^\+\d{1,3}\d{7,12}$");
                    if (!phoneRegExp.hasMatch(phone)) {
                      isPhoneNumberIsValidate = false;
                      return 'Enter a valid phone number (e.g., +1234567890)';
                    }
                    isPhoneNumberIsValidate = true;
                    return null;
                  },
                ),
                SizedBox(height: 25),
                AppButton(
                    enabled: forgetPasswordState,
                    width: double.infinity,
                    height: defaultButtonHeight,
                    backColor: AppTheme.mainAppColor,
                    text: "Send",
                    onPress: requestOTPForPhone),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void requestOTPForPhone() {
    if (formKey.currentState?.validate() == true) {
      context.push(changePasswordScreenRoute,
          extra: {PHONE_KEY: phoneController.text});
    }
    setState(() {});
  }

  void _updateButtonState() {
    bool isFull = phoneController.text.isNotEmpty;
    ref.read(forgetPasswordProvider.notifier).updateStatue(isFull);
  }
}
