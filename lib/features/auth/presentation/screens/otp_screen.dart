import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/app_routes.dart';
import 'package:flutter_base/core/localization/Keys.dart';
import 'package:flutter_base/features/auth/presentation/widgets/auth_header_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/Constants/Constants.dart';
import '../../../../core/Theme/app_theme.dart';
import '../../../../core/constants/eunms.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/otp_fields.dart';
import '../providers/auth_enable_btu_providers.dart';
import '../widgets/timer_counter.dart';

class OTPScreen extends ConsumerStatefulWidget {
  final String phone;
  final String? cityId;
  final String? email;
  final String? image;
  final String? name;
  final OTPType otpType;
  // final TypeOfMode? typeOfMode;
  const OTPScreen(
      {super.key,
      /*this.typeOfMode = TypeOfMode.ViewMode*/ required this.phone,
      required this.otpType,
      this.cityId,
      this.email,
      this.image,
      this.name});

  @override
  ConsumerState<OTPScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OTPScreen> {
  final GlobalKey<OTPFieldsState> otpFieldsKeys = GlobalKey();
  final GlobalKey<TimerTextState> timerKey = GlobalKey();
  var readyToResendOtp = false;
  @override
  Widget build(BuildContext context) {
    final optState = ref.watch(otpProvider);

    return Scaffold(
      appBar: CustomAppBar(
          appContext: context,
          title: context.tr(otpKey),
          navigated: true,
          isCenter: false,
          trailingWidget: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPaddingHorizontal),
            child: Center(
              child: Text(
                "اللغه العربيه",
                style: AppTheme.styleWithTextBlackAdelleSansExtendedFonts16w400,
              ),
            ),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AuthHeaderWidget(
                marginTop: 21,
                marginBottom: 48,
              ),
              Text(
                "Please Enter the code we just sent to ",
                style: AppTheme.styleWithTextGray7AdelleSansExtendedFonts16w400,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "phone ",
                          style: AppTheme
                              .styleWithTextGray7AdelleSansExtendedFonts16w400,
                          children: <TextSpan>[
                        TextSpan(
                          text: widget.phone,
                          style: AppTheme
                              .styleWithTextBlackAdelleSansExtendedFonts16w700
                              .copyWith(
                            decoration:
                                TextDecoration.underline, // Underline the text
                          ),
                        )
                      ])),
                  const SizedBox(
                    width: 8,
                  ),
                  // InkWell(child: SVGIcons.editIcon(),onTap: (){
                  //   context.pop();
                  // }),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              OTPFields(
                key: otpFieldsKeys,
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TimerText(
                        key: timerKey,
                        onTimerFinish: () {
                          setState(() {
                            readyToResendOtp = true;
                          });
                        },
                      )),
                  RichText(
                    text: TextSpan(
                      text: "Resend Code",
                      style: TextStyle(
                        color: readyToResendOtp
                            ? AppTheme.mainAppColor
                            : AppTheme.appGrey3, // Set the color to green
                        fontSize: 16.0,
                        decoration:
                            TextDecoration.underline, // Underline the text
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = !readyToResendOtp
                            ? null
                            : () {
                                // sendOtp();
                                setState(() {
                                  readyToResendOtp = false;
                                });
                              },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPaddingHorizontal),
                  child: AppButton(
                      enabled: optState,
                      width: double.infinity,
                      height: defaultButtonHeight,
                      backColor: AppTheme.mainAppColor,
                      text: "Verify",
                      onPress: verify)),
            ],
          ),
        ),
      ),
    );
  }

/*
  void sendOtp() async {
    ref.read(sendOtpForLoginStateProvider.notifier).sendOtp(widget.phone);
  }

  void verifyPhone(String phone,String? code) async {
    ref.read(confirmResetCodeStateProvider.notifier).confirmReset(phone, code);
  }

  void initFcmToken() async{
    //FCM
    final fcmToken = await FirebaseMessaging.instance.getToken();
    ref.read(updateFcmTokenStateProvider.notifier).calculateInstantOrder(
        fcmToken: fcmToken
    );
  }

  void login() async {
    var sessionId = ref.read(getSessionHandlerStateNotifier.notifier).checkIfSessionIdExist();
    if(sessionId?.isNotEmpty == true){
      ref.read(loginStateNotifierProvider.notifier)
          .login(widget.phone,sessionId: sessionId);
    }else{
      ref.read(loginStateNotifierProvider.notifier)
          .login(widget.phone);
    }
  }

  void signUp() {
    var sessionId = ref.read(getSessionHandlerStateNotifier.notifier).checkIfSessionIdExist();
    if(sessionId?.isNotEmpty == true){
      ref.read(signUpStateNotifierProvider.notifier).signUp(
          image: widget.image,
          name: widget.name,
          phone: widget.phone,
          email: widget.email?.isNotEmpty == true ? widget.email : null,
          cityId: "${widget.cityId}",
        sessionId: sessionId
      );
    }else{
      ref.read(signUpStateNotifierProvider.notifier).signUp(
          image: widget.image,
          name: widget.name,
          phone: widget.phone,
          email: widget.email?.isNotEmpty == true ? widget.email : null,
          cityId: "${widget.cityId}",
      );
    }

  }

  void updatePhone() {
    ref.read(updateProfileStateProvider.notifier).updateProfile(
        phone: widget.phone
    );
  }

  void updateMainScreen(){
    ref.read(homeDataStateNotifiers.notifier).getHomeData();
    ref.read(getNewOrderStateProvider.notifier).getOrders();
    ref.read(getCurrentOrderStateProvider.notifier).getOrders();
    ref.read(getFinishOrderStateProvider.notifier).getOrders();
    ref.read(getCanselOrderStateProvider.notifier).getOrders();
    ref.read(fetchCardDetailsStateNotifies.notifier).getCardDetails();
    ref.read(getWishListProductsStateNotifier.notifier).fetchAllProductsInWishlist();
    ref.read(getWishListServicesStateNotifier.notifier).fetchAllServicesInWishlist();
  }
*/

  void verify() {
    if (widget.otpType == OTPType.SignUp) {
      // go to home
    } else if (widget.otpType == OTPType.Update) {
      context.push(changePasswordScreenRoute, extra: {PHONE_KEY: widget.phone});
    }
  }
}
