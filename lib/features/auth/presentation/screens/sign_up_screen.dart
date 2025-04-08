import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/app_routes.dart';
import 'package:flutter_base/core/constants/constants.dart';
import 'package:flutter_base/core/constants/eunms.dart';
import 'package:flutter_base/core/localization/Keys.dart';
import 'package:flutter_base/core/utils/extensions/request_handle_extension.dart';
import 'package:flutter_base/core/widgets/app_button.dart';
import 'package:flutter_base/core/widgets/custom_app_bar.dart';
import 'package:flutter_base/features/auth/presentation/providers/auth_validation_provider.dart';
import 'package:flutter_base/features/auth/presentation/providers/usecase_provider.dart';
import 'package:flutter_base/features/auth/presentation/widgets/phone_number_field.dart';
import 'package:flutter_base/features/auth/presentation/widgets/auth_header_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/language_text.dart';
import '../providers/auth_validation_provider.dart';
import '../widgets/labeled_text_field.dart';
import '../widgets/phone_number.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  PhoneNumber? _phoneNumber;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool isPasswordVisiblePassword = true;

  bool isPasswordVisibleConfirmPassword = true;
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();
  bool isAgree = false;

  bool isFirstNameValidate = true;
  bool isLastNameValidate = true;
  bool isPhoneNumberValidate = true;
  bool isemailValidate = true;
  bool isPasswordValidate = true;
  bool isComfirmPasswordValidate = true;

  void _toggleCheckbox() {
    setState(() {
      isAgree = !isAgree;
    });
  }

  @override
  Widget build(BuildContext context) {
    final validState = ref.watch(validationSignUpProvider);
    debugPrint("this is Phone ${validState.containsKey("phone").toString()}");

    handleState(
      checkIfDataValidStateNotifierProvider,
      showLoading: true,
      onSuccess: (res) {
        goToSendOtp();
      },
      onFail: (res) {
        Map<String, String> errorMap = {};

        for (String error in (res.errors ?? [])) {
          if (error.contains("email")) {
            errorMap["email"] = error;
          }
          if (error.contains("phone")) {
            errorMap["phone"] = error;

          }
          if (error.contains("name")) {
            errorMap["name"] = error;
          }
        }
        ref.read(validationSignUpProvider.notifier).updateStatue(errorMap);
      },
    );
    return Scaffold(
      appBar: CustomAppBar(
        navigated: true,
        appContext: context,
        title: context.tr(signUpKey),
        trailingWidget: const Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPaddingHorizontal),
          child: LanguageText(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AuthHeaderWidget(
                marginTop: 0.0,
                marginBottom: 48,
              ),
              LabeledTextField(
                controller: _firstNameController,
                focusNode: _focusNode,
                hint: "yourname",
                isvalidate: isFirstNameValidate,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    isFirstNameValidate = false;
                    return "First name is required";
                  }
                  final RegExp nameRegExp = RegExp(r"^[a-zA-Z]{2,}$");
                  if (!nameRegExp.hasMatch(value)) {
                    isFirstNameValidate = false;

                    return "letters only, at least 2 characters";
                  }
                  isFirstNameValidate = true;

                  return null;
                },
                label: const Text(
                  "Firstname",
                  style: AppTheme.style14BoldBlack,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              LabeledTextField(
                isvalidate: isLastNameValidate,
                controller: _lastNameController,
                hint: "yourname",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    isLastNameValidate = false;
                    return "Last name is required";
                  }
                  final RegExp nameRegExp = RegExp(r"^[a-zA-Z]{2,}$");
                  if (!nameRegExp.hasMatch(value)) {
                    isLastNameValidate = false;

                    return "letters only, at least 2 characters";
                  }
                  isLastNameValidate = true;
                  return null;
                },
                label: const Text(
                  "Lastname",
                  style: AppTheme.style14BoldBlack,
                ),
              ),

              const SizedBox(height: 16),
              PhoneNumberField(
                isPhoneNumberIsValidate: !validState.containsKey("phone"),
                controller: _phoneController,
                validator: (phone) {
                  if (_phoneNumber?.completeNumberWithPlus == null ||
                      _phoneNumber?.completeNumberWithPlus.isEmpty == true) {
                    isPhoneNumberValidate = false;
                    return 'Phone number is required';
                  }
                  final RegExp phoneRegExp = RegExp(r"^\+\d{1,3}\d{7,12}$");
                  if (!phoneRegExp
                      .hasMatch(_phoneNumber!.completeNumberWithPlus)) {
                    isPhoneNumberValidate = false;
                    return 'Enter a valid phone number (e.g., +1234567890)';
                  }
                  if (validState.containsKey("phone")) {
                    String errorMessage = validState["phone"]!.replaceFirst("phone: ", "");
                    return errorMessage;
                  }
                  // isPhoneNumberValidate = true;

                  return null;
                },
                onChanged: (value) {
                  _phoneNumber = value;
                  ref.read(validationSignUpProvider.notifier).updateStatue({});
                  print("onChanged phone : $value");
                },
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                mode: AutovalidateMode.onUserInteraction,
                isvalidate: !validState.containsKey("email"),
                controller: _emailController,
                hint: "example@gmail.com",
                validator: (email) {
                  if (email != null && email.isNotEmpty) {
                    final RegExp emailRegExp = RegExp(
                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                    if (!emailRegExp.hasMatch(email)) {
                      // isemailValidate = false;
                      return 'Enter a valid email address';
                    }
                  }
                  if (validState.containsKey("email")) {
                    String errorMessage = validState["email"]!.replaceFirst("email: ", "");
                    return errorMessage;
                  }

                  // isemailValidate = true;
                  return null; // Email is optional, so we allow empty input
                },
                label: const Text(
                  "Email",
                  style: AppTheme.style14BoldBlack,
                ),
                onChanged: (value) {
                  _emailController.text = value;
                  ref.read(validationSignUpProvider.notifier).updateStatue({});
                },
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                isvalidate: isPasswordValidate,
                isvisible: isPasswordVisiblePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisiblePassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppTheme.gray,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisiblePassword = !isPasswordVisiblePassword;
                    });
                  },
                ),
                controller: _passwordController,
                hint: "*****************************",
                errorMaxLine: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    isPasswordValidate = false;
                    return "Password is required";
                  }

                  final RegExp passwordRegExp =
                      RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,50}$");
                  if (!passwordRegExp.hasMatch(value)) {
                    isPasswordValidate = false;

                    return "Password must be at least 8 characters, include at least one letter and one number";
                  }
                  isPasswordValidate = true;

                  return null;
                },
                label: const Text(
                  "Password",
                  style: AppTheme.style14BoldBlack,
                ),
              ),
              const SizedBox(height: 16),
              LabeledTextField(
                isvalidate: isComfirmPasswordValidate,
                controller: _confirmPasswordController,
                isvisible: isPasswordVisibleConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisibleConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: AppTheme.gray,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisibleConfirmPassword =
                          !isPasswordVisibleConfirmPassword;
                    });
                  },
                ),
                hint: "*****************************",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    isComfirmPasswordValidate = false;
                    return "Confirm Password is required";
                  }

                  final RegExp passwordRegExp =
                      RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,50}$");

                  if (!passwordRegExp.hasMatch(value)) {
                    setState(() {
                      isComfirmPasswordValidate = false;
                    });

                    return "Password must be at least 8 characters, include at least one letter and one number.";
                  } else if (value != _passwordController.text) {
                    setState(() {
                      isComfirmPasswordValidate = false;
                    });

                    return "Passwords do not match";
                  }
                  isComfirmPasswordValidate = true;

                  return null;
                },
                label: const Text(
                  "Confirm Password",
                  style: AppTheme.style14BoldBlack,
                ),
                errorMaxLine: 3, // Allows multi-line error messages if needed
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  GestureDetector(
                    onTap: _toggleCheckbox,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                          color: isAgree
                              ? AppTheme.orangeAppColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: isAgree
                                  ? AppTheme.orangeAppColor
                                  : AppTheme.codeA1A4AAColor)),
                      child: isAgree
                          ? const Icon(Icons.check,
                              color: Colors.white, size: 15)
                          : null,
                    ),
                  ),
                  const Text(' Agree to ', style: AppTheme.styleblack16normal),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'The Terms and conditions',
                      style: AppTheme.styleblack16normal.copyWith(
                        color: AppTheme.mainAppColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              AppButton(
                width: double.infinity,
                height: defaultButtonHeight,
                backColor: AppTheme.mainAppColor,
                text: "Continue",
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    if(isAgree==true){
                      setState(() {});
                      checkIfDataValid();
                    }else{
                      Fluttertoast.showToast(
                        msg: "Please Agree to the Terms to Conditions",
                        toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
                        gravity: ToastGravity.BOTTOM, // TOP, CENTER, BOTTOM
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                    // goToSendOtp();
                  }
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Have an account?   '),
                  GestureDetector(
                    onTap: () {
                      context.push(loginScreenRoute);
                    },
                    child: Text(
                      'Login',
                      style: AppTheme.styleblack16normal.copyWith(
                        color: AppTheme.mainAppColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void goToSendOtp() {
    context.push(otpScreenRoute, extra: {
      FIRST_NAME_KEY: _firstNameController.text,
      LAST_NAME_KEY: _lastNameController.text,
      PHONE_KEY: _phoneNumber?.completeNumberWithPlus,
      EMAIL_KEY: _emailController.text,
      PASSWORD_KEY: _passwordController.text,
      OTP_TYPE_KEY: OTPType.SignUp
    });
  }

  void checkIfDataValid() {
    ref.read(checkIfDataValidStateNotifierProvider.notifier).call(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        phoneNumber: _phoneNumber?.completeNumberWithoutPlus,
        password: _passwordController.text);
  }

  void sendOtp() {
    context.go(otpScreenRoute, extra: {});
  }
}
