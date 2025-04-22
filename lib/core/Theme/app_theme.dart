// core/Theme/app_theme.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static const Color mainAppColor = Color(0xFFB08A4E);
  static const Color mainAppColorLight = Color(0xFFF7DBDE);
  static const Color mainAppColorLight2 = Color(0xFFFDE9EB);
  static const Color mainAppColorBright = Color(0xFFe6f4ff);
  static const Color mainAppColorDark = Color(0xFF003A59);
  static const Color secondaryAppColorLight = Color(0xFF4FC2FF);
  static const Color secondaryAppColorDark = Color(0xFF439FD0);
  static const Color secondaryTempAppColorDark = Color(0xFFF04741);
  static const Color orangeAppColor = Color(0xFFFF7F50);
  static const Color gray = Color(0xFFD0D1D4);
  static const Color lightGreen = Color(0xFFE7F6E5);
  static const Color filterOptionBackground = Color(0xFFE6F2F2);
  static const Color filterOptionTextColor = Color(0xFF008080);
  static const Color appGreen = Color(0xFF0DA500);
  static const Color codeA1A4AAColor=Color(0xffA1A4AA);
  static const Color whiteColor = Colors.white;
  static const Color appGrey = Color(0xFFBEBEBE); //#E5E5E5
  static const Color appGrey2 = Color(0xFFECEDEE);
  static const Color appGrey3 = Color(0xFFe5e5e5);
  static const Color appGrey4 = Color(0xFF737780);
  static const Color appGrey5 = Color(0xFFCECECE);
  static const Color appGrey6 = Color(0xFFE6E9EC);
  static const Color appGrey7 = Color(0xFF8088A4);
  static const Color appGrey8 = Color(0xFFE9EAEF);
  static const Color appGrey9 = Color(0xFFF4F5F7);
  static const Color appGrey10 = Color(0xFFA5ABBF);
  static const Color appGrey11 = Color(0x839B9B9B);
  static const Color appGrey12 = Color(0xFFEBECEF);
  static const Color appGrey13 = Color(0xFF667085);
  static const Color appGrey14 = Color(0x14000000); // box-shadow: 0px -6px 16px 0px #00000014;
  static const Color appGrey15 = Color(0xff444955);
  static const Color appGrey16 = Color(0xff525252);
  static const Color appGrey17 = Color(0xffA3A3A3);
  static const Color appGrey18 = Color(0xffEAEAEA);
  static const Color appGrey19 = Color(0xffF5F5F5);
  static const Color appGrey20 = Color(0xff737373);
  static const Color appHeaderOne = Color(0xFF225268);
  static const Color appHeaderTwo = Color(0xFF2298B8);

  static const Color appGunmetal = Color(0xFF333740);
  static const Color appLightGrey = Color(0xFFe5e5e5);
  static const Color appLightGreyV2 = Color(0xFFF0F0F0);
  static const Color appDarkerGrey = Color(0xFF898989);

  static const Color failureColor = Color(0xFFc61313);

  static const Color successColor = Color(0xFF7cbf2b);
  static const Color preparingColor = Color(0xB802B730);
  static const Color pendingColor = Color(0xFFff904a);
  static const Color readyToShippingColor = Color(0xFFFFB58B);
  static const Color finishColor = Color(0xFF02B730);
  static const Color lightAlert = Color(0xFFeb6866);
  static const Color blue = Color(0xFF1256d2);
  static const Color appBlue = Color(0xFF0582D2);

  static const Color appRed = Color(0xFFFF3B30);

  static const Color selectedBackgroundColor = Color(0xFF23B574);
  static const Color mainBackgroundLightColor = Color(0xFFFCFCFC);
  static const Color mainAppBackgroundColor = Color(0xFFFAFAFA);
  static const Color mainBackgroundDarkColor = Color(0xFF0E0314);
  static const Color mainBackgroundSemiDarkColor = Color(0xFF0E0322);
  static const Color cardColor = Color(0xFFfcfcfc);
  static const Color lightTextColor = Colors.white;
  static Color? lightDetailTextColor = Colors.grey[200];
  static const Color darkDetailTextColor = Colors.black54;
  static const Color darkTextColor = Colors.black;
  static const Color code22252BColor = Color(0xff22252B);

  static const kPrimaryColor = Color(0xFF1ad3b0);
  static const kContentColorLightTheme = Color(0xFF1D1D35);
  static const kContentColorDarkTheme = Color(0xFFF5FCF9);
  static const kWarninngColor = Color(0xFFF3BB1C);
  static const kYellow = Color(0xFFEC9922);
  static const appYellow = Color(0xFFCDCB02);
  static const kErrorColor = Color(0xFFF03738);
  static const code8088A4Color = Color(0xFF8088A4);
  static const code999999Color = Color(0xff999999);
  static const code006060Color = Color(0xff006060);
  static const code008080Color = Color(0xff008080);

  static const kDefaultPadding = 20.0;

  static const MaterialColor appSwatch = MaterialColor(
    0xFFE21B33,
    <int, Color>{
      50: Color(0xFFE21B33),
      100: Color(0xFFE21B33),
      200: Color(0xFFE21B33),
      300: Color(0xFFE21B33),
      400: Color(0xFFE21B33),
      500: Color(0xFFE21B33),
      600: Color(0xFFE21B33),
      700: Color(0xFFE21B33),
      800: Color(0xFFE21B33),
      900: Color(0xFFE21B33),
    },
  );

  static const TextTheme appTextTheme = TextTheme(
    bodyLarge: TextStyle(
        color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
    bodyMedium: TextStyle(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
    bodySmall: TextStyle(
        color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
    displayLarge: TextStyle(
        color: Colors.black, fontSize: 26, fontWeight: FontWeight.w800),
    displayMedium: TextStyle(
        color: Colors.black, fontSize: 22, fontWeight: FontWeight.w800),
    displaySmall: TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800),
    titleMedium: TextStyle(
        color: Colors.black, fontSize: 13, fontWeight: FontWeight.normal),
    titleSmall: TextStyle(
        color: appDarkerGrey, fontSize: 12, fontWeight: FontWeight.normal),
    titleLarge: TextStyle(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
  );


  static const appBlackColor2 = Color(0xFF262626);
  static const appBlackColor3 = Color(0xFF171717);

  static final mediumBodyBlue =
      appTextTheme.bodyMedium?.copyWith(color: AppTheme.mainAppColor);

  static final mediumBodyBlue2 = appTextTheme.bodyMedium
      ?.copyWith(color: AppTheme.mainAppColor, fontSize: 14);

  static const appBlueColor3 = Color(0xFF0E1427);
  static const appBlueColor4 = Color(0xFF3B82F6);

  static ThemeData lightTheme = ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      primaryColor: mainAppColor,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
      primaryColorLight: mainAppColor,
      scaffoldBackgroundColor: mainBackgroundLightColor,
      bottomAppBarTheme: BottomAppBarTheme(
        color: Colors.white,
      ),
      dividerColor: Colors.transparent,
      expansionTileTheme: const ExpansionTileThemeData(
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent),
      radioTheme:
          RadioThemeData(fillColor: MaterialStateProperty.all(appSwatch)),
      hintColor: Colors.grey,
      fontFamily: 'Proxima',
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(mainBackgroundDarkColor))),
      popupMenuTheme: const PopupMenuThemeData(color: Colors.white),
      checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(Colors.white),
          fillColor: MaterialStateProperty.all(appSwatch)),
      textTheme: appTextTheme,
      tabBarTheme: const TabBarTheme(
          indicatorColor: mainAppColor,
          unselectedLabelColor: appGrey2,
          labelColor: mainAppColor),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: appSwatch)
          .copyWith(background: Colors.white));

  // Text style
  static const TextStyle styleWithTextBlackAdelleSansExtendedFonts20w700 =
      TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700);

  static const TextStyle styleWithTextAppBlackColor3AdelleSansExtendedFonts20w500 =
      TextStyle(color: appBlackColor3, fontSize: 20, fontWeight: FontWeight.w500);

  static const TextStyle styleblack16normal = TextStyle(
      color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal);
  static const TextStyle styleColorAppGunmetal40FontSize20W700 =
      TextStyle(color: appGunmetal, fontSize: 20, fontWeight: FontWeight.w700);
  static const TextStyle style14W500code8088A4Color = TextStyle(
      color: code8088A4Color,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: "cairepro");
  static const TextStyle styleWithAppGunmetalLinkFonts14w400 =
      TextStyle(color: appGunmetal, fontSize: 14, fontWeight: FontWeight.w400);
  static const TextStyle fontStyle24W70022252BColor = TextStyle(
      color: code22252BColor,
      fontSize: 24,
      fontWeight: FontWeight.w700,
      fontFamily: "cairepro");
  static const TextStyle fonStyle13W50022252BColor = TextStyle(
      fontSize: 13, fontWeight: FontWeight.w500, color: code22252BColor);
  static const TextStyle styleWithAppGrey7Fonts14w400 =
      TextStyle(color: appGrey7, fontSize: 14, fontWeight: FontWeight.w400);

  static const TextStyle styleWithMainAppColor7Fonts14w400 =
      TextStyle(color: mainAppColor, fontSize: 14, fontWeight: FontWeight.w400);

  static const TextStyle styleWithTextBlackAdelleSansExtendedFonts32w400 =
      TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.w400);

  static const TextStyle styleWithTextBlackAdelleSansExtendedFonts18w700 =
      TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700);

  static const TextStyle styleWithTextMainAppColorAdelleSansExtendedFonts18w700 =
      TextStyle(color: mainAppColor, fontSize: 18, fontWeight: FontWeight.w700);

  static const TextStyle styleWithTextBlackAdelleSansExtendedFonts18w400 =
      TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400);

  static const TextStyle styleWithTextBlackAdelleSansExtendedFonts18w500 =
      TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500);

  static const TextStyle styleWithTextBlackAdelleSansExtendedFonts16w700 =
      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700);
  static const TextStyle style15W400appGrey7Color =
      TextStyle(color: appGrey7, fontSize: 16, fontWeight: FontWeight.w400);

  static const TextStyle styleWithTextGray7AdelleSansExtendedFonts16w400 =
      TextStyle(color: appGrey7, fontSize: 16, fontWeight: FontWeight.w400);
  static const TextStyle style20SemiBoldcode333740 =
      TextStyle(color: appGunmetal, fontWeight: FontWeight.w500, fontSize: 20);
  static const TextStyle styleWithTextRedAdelleSansExtendedFonts16w400 =
      TextStyle(color: mainAppColor, fontSize: 16, fontWeight: FontWeight.w400);
static const TextStyle fontStyleW700Size20ColorWhite=TextStyle(
  color: whiteColor,
  fontWeight: FontWeight.w700,
  fontSize: 20
);
  static const TextStyle fontStyle16color333740 = TextStyle(
      color: Color(0xff333740), fontWeight: FontWeight.w400, fontSize: 16);
  static const TextStyle styleWithTextGray7AdelleSansExtendedFonts12w400 =
      TextStyle(color: appGrey7, fontSize: 12, fontWeight: FontWeight.w400);

  static const TextStyle fontStyleW70018code008080Color = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: code008080Color,
  );

  static const TextStyle styleWithTextMainAppColorAdelleSansExtendedFonts12w500 =
      TextStyle(color: mainAppColor, fontSize: 12, fontWeight: FontWeight.w500);

  static const TextStyle styleWithTextGreenAdelleSansExtendedFonts12w400 =
      TextStyle(color: appGreen, fontSize: 12, fontWeight: FontWeight.w400);

  static const TextStyle styleWithTextAppBlackColor3CeraProFonts12w500 =
      TextStyle(color: appBlackColor3, fontSize: 12, fontWeight: FontWeight.w500);

  static const TextStyle styleWithTextAppAppGrey16CeraProFonts12w400 =
      TextStyle(color: appGrey16, fontSize: 12, fontWeight: FontWeight.w400);

  static const TextStyle styleWithTextAppAppGrey16CeraProFonts12w500 =
      TextStyle(color: appGrey16, fontSize: 12, fontWeight: FontWeight.w500);

  static const TextStyle styleWithTextAppAppGrey20CeraProFonts12w400 =
      TextStyle(color: appGrey20, fontSize: 12, fontWeight: FontWeight.w400);

  static const TextStyle styleWithTextAppGreen17AdelleSansExtendedFonts113w400 =
      TextStyle(color: appGrey17, fontSize: 13, fontWeight: FontWeight.w400);

  static const TextStyle styleWithTextAppGreen17AdelleSansExtendedFonts14w400 =
      TextStyle(color: appGrey17, fontSize: 14, fontWeight: FontWeight.w400);

  static const TextStyle styleWithTextAppBlackColor3AdelleSansExtendedFonts14w700 =
      TextStyle(color: appBlackColor3, fontSize: 14, fontWeight: FontWeight.w700);

  static const TextStyle styleWithTextAppGreen20AdelleSansExtendedFonts14w400 =
      TextStyle(color: appGrey20, fontSize: 14, fontWeight: FontWeight.w400);

  static const TextStyle styleWithTextGray13AdelleSansExtendedFonts11w400 =
      TextStyle(color: appGrey13, fontSize: 11, fontWeight: FontWeight.w400);

  static const TextStyle styleWithTextGray7AdelleSansExtendedFonts11w500 =
      TextStyle(color: appGrey7, fontSize: 11, fontWeight: FontWeight.w500);

  static const TextStyle styleWithTextRedAdelleSansExtendedFonts11w500 =
      TextStyle(color: mainAppColor, fontSize: 11, fontWeight: FontWeight.w500);

  static const TextStyle styleWithTextBlackAdelleSansExtendedFonts16w400 =
      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400);

  static const TextStyle styleWithTextBlackAdelleSansExtendedFonts16w500 =
      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);

  static const TextStyle styleWithTextAppBlueColor3SansExtendedFonts16w700 =
      TextStyle(color: appBlueColor3, fontSize: 20, fontWeight: FontWeight.w700);

  static const TextStyle styleWithTextRedAdelleSansExtendedFonts16w500 =
      TextStyle(color: mainAppColor, fontSize: 16, fontWeight: FontWeight.w500);

  static const TextStyle styleWithTextWhiteAdelleSansExtendedFonts16w500 =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500);

  static const TextStyle styleWithTextAppBlackColor3AdelleSansExtendedFonts16w500 =
      TextStyle(color: appBlackColor3, fontSize: 16, fontWeight: FontWeight.w500);

  static const TextStyle styleWithTextAppBlueColor3AdelleSansExtendedFonts16w500 =
      TextStyle(color: appBlueColor3, fontSize: 16, fontWeight: FontWeight.w500);

  static const TextStyle styleWithTextAppGrey16AdelleSansExtendedFonts16w500 =
      TextStyle(color: appGrey16, fontSize: 16, fontWeight: FontWeight.w500);

  static const TextStyle styleWithTextBlackCeraProFonts22w700 = TextStyle(
      color: Colors.black , fontSize: 22, fontWeight: FontWeight.w400);

  static const TextStyle styleWithTextBlackAdelleSansExtendedFonts14w400 =
      TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400);

  static const TextStyle styleWithTextBlackSmRegularFonts14w400 =
      TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400);

  static const TextStyle styleWithTextAppBlueColor4SmRegularFonts14w500 =
      TextStyle(color: appBlueColor4, fontSize: 14, fontWeight: FontWeight.w500);

  static const TextStyle styleWithTextAppGrey16CeraProFonts14w500 =
      TextStyle(color: appGrey16, fontSize: 14, fontWeight: FontWeight.w500);

    static const TextStyle styleWithTextMainAppColorCeraProFonts14w500 =
      TextStyle(color: mainAppColor, fontSize: 14, fontWeight: FontWeight.w500);

  static const TextStyle styleWithTextWhiteAdelleSansExtendedFonts14w400 =
      TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400);

  static const TextStyle styleWithTextAppGrey4RegularFonts14w400 =
      TextStyle(color: appGrey4, fontSize: 14, fontWeight: FontWeight.w400);

  static const TextStyle style14normalblack = TextStyle(
      color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal);
  static const TextStyle style14BoldBlack =
      TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold);

  static const TextStyle styleWithTextBlackAdelleSansExtendedFonts14w500 =
      TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500);

  static const TextStyle styleWithTextWhiteAdelleSansExtendedFonts14w500 =
      TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500);

  static const TextStyle styleWithTextAppGrey7AdelleSansExtendedFonts14w400 =
      TextStyle(color: appGrey7, fontSize: 14, fontWeight: FontWeight.w400);
  static const TextStyle style15SemiBoldBlack =
      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);
  static const TextStyle style14W400code8088A4 = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: code8088A4Color);

  static ThemeData darkTheme = ThemeData(
    primaryColor: secondaryAppColorDark,
    primaryColorLight: mainAppColor,
    expansionTileTheme: const ExpansionTileThemeData(
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent),
    radioTheme: RadioThemeData(fillColor: MaterialStateProperty.all(appSwatch)),
    appBarTheme: const AppBarTheme(
        backgroundColor: mainBackgroundSemiDarkColor,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
    hintColor: Colors.grey,
    dividerColor: Colors.transparent,
    scaffoldBackgroundColor: mainBackgroundDarkColor,
    fontFamily: 'Proxima',
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(mainBackgroundDarkColor))),
    checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(Colors.white),
        fillColor: MaterialStateProperty.all(appSwatch)),
    popupMenuTheme:
        const PopupMenuThemeData(color: mainBackgroundSemiDarkColor),
    cardColor: cardColor,
    textTheme: appTextTheme,
    bottomAppBarTheme: BottomAppBarTheme(color: mainBackgroundSemiDarkColor),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: appSwatch)
        .copyWith(background: mainBackgroundSemiDarkColor),
  );

  static ThemeData expandedTileTheme =
      ThemeData(dividerColor: Colors.transparent);
}

const appGradiant = LinearGradient(
  colors: [AppTheme.mainAppColor, AppTheme.secondaryAppColorLight],
  begin: AlignmentDirectional.bottomStart,
  end: AlignmentDirectional.topEnd,
);

class TextFormatters {
  static FilteringTextInputFormatter onlyLetters =
      FilteringTextInputFormatter.allow(RegExp('[a-z A-Z ا-ي]'));
  static FilteringTextInputFormatter nonStartingZero =
      FilteringTextInputFormatter.deny(
    RegExp(r'^0+'),
  );
  static FilteringTextInputFormatter nonArabicPhone =
      FilteringTextInputFormatter.allow(
    RegExp('[0-9]'),
  );
}
