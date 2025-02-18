import 'package:flutter_base/core/utils/FaceIDHelper.dart';
import 'package:flutter_base/core/utils/extensions/request_handle_extension.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_base/features/auth/presentation/widgets/phone_number_field.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../providers/auth_validation_providers.dart';
import '../providers/usecase_provider.dart';
import '../widgets/auth_header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/localization/Keys.dart';
import '../widgets/labeled_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = true;

  @override
  void initState() {
    for (var controller in [_phoneController, _passwordController]) {
      controller.addListener(_updateLoginState);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final validationLoginState = ref.watch(loginProvider);

    handleState(loginStateNotifierProvider, showLoading: true,
        onSuccess: (res) {
      navigateToMainScreen();
    });

    return Scaffold(
      appBar: CustomAppBar(
        navigated: true,
        appContext: context,
        title: context.tr(signInKey),
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
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: defaultPaddingHorizontal),
          child: Column(
            children: [
              AuthHeaderWidget(
                marginTop: 44,
                marginBottom: 64,
              ),
              PhoneNumberField(
                controller: _phoneController,
              ),
              SizedBox(height: 14),
              LabeledTextField(
                isvisible: isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: AppTheme.gray,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
                controller: _passwordController,
                hint: /* context.tr(OldPasswordKey) */ "**********",
                label: Text(
                  "Password",
                  style: AppTheme.style14BoldBlack,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  const Spacer(),
                  InkWell(
                      onTap: _forgetPassword,
                      child: Text("Forget Password?",
                          style: AppTheme.styleWithAppGunmetalLinkFonts14w400
                              .copyWith(decoration: TextDecoration.underline)))
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                        enabled: validationLoginState,
                        height: defaultButtonHeight,
                        text: "Sign In",
                        onPress: login),
                  ),
                  SizedBox(
                    width: defaultPaddingHorizontal,
                  ),
                  InkWell(
                    onTap: _signInWithFaceId,
                    child: Container(
                      decoration: BoxDecoration(
                          color: validationLoginState
                              ? AppTheme.mainAppColor
                              : AppTheme.appGrey2,
                          borderRadius: BorderRadius.circular(8)),
                      width: 56,
                      height: 56,
                      child: Center(
                          child: SVGIcons.localSVG(faceId,
                              width: 32,
                              height: 32,
                              color: validationLoginState
                                  ? Colors.white
                                  : Colors.black)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.symmetric(horizontal: 14.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        height: 1,
                        color: AppTheme.gray,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 12.0),
                      child: Text(
                        "Or sign in with",
                        style: AppTheme.styleWithTextAppGrey4RegularFonts14w400,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        height: 1,
                        color: AppTheme.gray,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: _signInWithApply,
                      child: SVGIcons.localImage(appleBtn)),
                  SizedBox(
                    width: 24,
                  ),
                  InkWell(
                      onTap: _signInWithGoogle,
                      child: SVGIcons.localImage(googleBtn)),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account?",
                    style: AppTheme
                        .styleWithTextBlackAdelleSansExtendedFonts16w400,
                  ),
                  InkWell(
                    onTap: _signUp,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        "Sign Up",
                        style: AppTheme
                            .styleWithTextRedAdelleSansExtendedFonts16w400
                            .copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppTheme.mainAppColor),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (var controller in [_phoneController, _passwordController]) {
      controller.dispose();
    }
  }

  void _forgetPassword() {
    context.push(forgetPasswordScreenRoute);
  }

  void _updateLoginState() {
    bool allFull = [_phoneController, _passwordController]
        .every((controller) => controller.text.length > 1);
    ref.read(loginProvider.notifier).updateStatue(allFull);
  }

  void _signUp() {
    context.push(signUpScreenRoute);
  }

  void _signInWithApply() {}

  void _signInWithGoogle() {}

  void _signInWithFaceId() async {
    bool isSuccess = await FaceIDHelper.authenticateWithFaceID();
    print("process is : $isSuccess");
  }

  void login() {
    ref.read(loginStateNotifierProvider.notifier).call(
      phoneNumber: _phoneController.text,
      password: _passwordController.text
    );
  }
}
