import 'package:flutter/material.dart';
import '../../../../core/Utils/Extintions.dart';
import '../../../../core/utils/extensions/request_handle_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/Theme/app_theme.dart';
import '../../../../core/Theme/app_theme_handler.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/providers/http_provider.dart';
import '../../../../core/utils/Extensions/utils_exts.dart';
import '../../../../core/widgets/svg_icons.dart';
import '../../domain/providers/user_provider.dart';
import '../providers/usecase_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen();
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  double _opc = 0.0;
  late AppThemeMode _appThemeMode;
  bool isThereUser = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      UtilsExts.handleStatusBarColorWithIcon(
          statusBarColor: AppTheme.mainAppColor);

      final client = ref.read(userProvider.notifier).checkIfUserExist();
      ref.read(userProvider.notifier).setUser(client);
      ref.read(httpOperationsProvider).userToken = client?.token;

      context.go(loginScreenRoute);
      if (client != null) {
        // initFcmToken();
        // context.go(R_MainScreen);
      } else {
        // if(prefs.getBool(doneLandingKey) == true){
        //   context.go(R_MainScreen);
        // }else {
        //   context.push(R_OnBoardingScreen);
        // }
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    handleState(loginStateNotifierProvider, showLoading: true);
    return Scaffold(
      body: Center(
        child: Container(
          width: context.getScreenSize.width,
          height: context.getScreenSize.height,
          decoration: const BoxDecoration(color: AppTheme.mainAppColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              TweenAnimationBuilder<double>(
                  curve: Curves.ease,
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(seconds: 4),
                  builder:
                      (BuildContext context, double opacity, Widget? child) {
                    return Opacity(
                        opacity: opacity, child: SVGIcons.shareIcon());
                  }),
              const Spacer(),
            ],
          ),
        ),
      ),
      backgroundColor: AppTheme.mainBackgroundLightColor,
    );
  }

  @override
  void dispose() {
    super.dispose();
    UtilsExts.handleStatusBarColorWithIcon();
  }
}
