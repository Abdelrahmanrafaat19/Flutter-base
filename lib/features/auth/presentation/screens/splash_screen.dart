import 'package:flutter/material.dart';
import 'package:flutter_base/core/Constants/Constants.dart';
import 'package:flutter_base/features/home/persentaion/Providers/usecase_provider.dart';
import 'package:flutter_base/features/location/domain/address_storage.dart';
import 'package:flutter_base/features/location/presentaion/providers/use_cases_provider.dart';
import '../../../../core/Utils/Extintions.dart';
import '../../../../core/localization/LanguageProvider.dart';
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
import 'dart:convert';
import 'package:http/http.dart' as http;
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

      checkAndUpdateUserLocationIfExist();

      if (client != null) {
        ref.read(userProvider.notifier).setUser(client);
      }
      commonCalls();

      if (client != null) {
        // initFcmToken();
        context.go(mainScreenRoute);
      } else {
        // if(prefs.getBool(doneLandingKey) == true){
        //   context.go(R_MainScreen);
        // }else {

        UtilsExts.handleStatusBarColorWithIcon();
        context.push(loginScreenRoute);
        // }
      }
    });
    WidgetsBinding.instance.addPersistentFrameCallback((callback){
      // getLocation();
    });
    super.initState();
  }

  Future<void> getAddressFromLatLngGoogle({
    required double lat,
    required double lng,
    required String apiKey,
  }) async {
    final url = Uri.parse(
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey",
    );
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == 'OK' && data['results'].isNotEmpty) {
          String formattedAddress = data['results'][0]['formatted_address'];
          print("Google Address: $formattedAddress");
        } else {
          print("No results found");
        }
      } else {
        print("Failed to fetch address. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
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
              // TweenAnimationBuilder<double>(
              //     curve: Curves.ease,
              //     tween: Tween<double>(begin: 0.0, end: 1.0),
              //     duration: const Duration(seconds: 4),
              //     builder:
              //         (BuildContext context, double opacity, Widget? child) {
              //       return Opacity(
              //           opacity: opacity, child: SVGIcons.shareIcon());
              //     }),
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
  }

  void commonCalls() {
    ref.read(fetchAllCuisinesStateNotifierProvider.notifier).call(
        page: "0",
        size: "1000",
        localeIsoCode: /*ref.watch(langProvider).toString()*/ "en",
        featured: true,
        fetchRestaurants: false,
        cuisineIds: []);
  }

  void checkAndUpdateUserLocationIfExist() {
    ref
        .read(updateUserLocationStateNotifierProvider.notifier)
        .updateUserLocation(AddressStorage.checkIfUserHasLocation());
  }

  void getLocation() async{
    var address = await getAddressFromLatLngGoogle(
      lat: 31.2001,
      lng: 29.9187,
      apiKey: googleApiKey,
    );
  }
}
