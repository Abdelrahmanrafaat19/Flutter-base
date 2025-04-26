import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:intl/intl.dart';
class UtilsExts {

    static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    static void handleStatusBarColorWithIcon(
        {Color? statusBarColor = AppTheme.mainAppBackgroundColor, Brightness? statusBarIcons = Brightness.dark}) {
        SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(statusBarIconBrightness: statusBarIcons)
        );
    }

    static String getCurrency(String currencyName) {
        var format = NumberFormat.simpleCurrency(locale: Platform.localeName, name: currencyName);
        return format.currencySymbol;
    }

    static void lockScreenOrientations(isLandscape){
        SystemChrome.setPreferredOrientations([
            if(isLandscape) DeviceOrientation.landscapeRight,
            if(isLandscape) DeviceOrientation.landscapeLeft,
            if(!isLandscape) DeviceOrientation.portraitDown,
            if(!isLandscape) DeviceOrientation.portraitDown,
        ]);
    }


    static void unLockScreenOrientations(){
        SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
        ]);
    }

    static  String getCountryFlag(String prefix){
        int flagOffset = 0x1F1E6;
        int asciiOffset = 0x41;

        String country = prefix;

        int firstChar = country.codeUnitAt(0) - asciiOffset + flagOffset;
        int secondChar = country.codeUnitAt(1) - asciiOffset + flagOffset;

        String flag = String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
        return flag;
    }


    static isThereCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;

}

extension StringExtension on String {
    String capitalize() {
        return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }

    bool toBool() => this == "Yes";

    String convertToTitleCase() {
        List<String> words = split('-');
        List<String> titleCaseWords = [];

        for (String word in words) {
            String capitalizedWord = word.isNotEmpty
                ? word[0].toUpperCase() + word.substring(1)
                : word;
            titleCaseWords.add(capitalizedWord);
        }

        return titleCaseWords.join(' ');
    }
}

extension EnumByName<T extends Enum> on Iterable<T> {

    T byNameOrDefault(String name,) {
        for (var value in this) {
            if (value.name == name) return value;
        }
        return this.first;
    }
}

extension StringValidators on String {
    bool get containsUppercase => contains(RegExp(r'[A-Z]'));
    bool get containsLowercase => contains(RegExp(r'[a-z]'));

    meetsPasswordRequirements() {
        RegExp regEx = new RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+");
        return regEx.hasMatch(this);
    }
}


extension DoubleExt on double {
    String toEuro() {
        return NumberFormat.simpleCurrency(
            name: 'EUR',
        ).format(this);
    }

    String toSGD() {
        return NumberFormat.simpleCurrency(
            name: 'SGD',
        ).format(this);
    }
    String toUSD() {
        return NumberFormat.simpleCurrency(
            name: 'USD',
        ).format(this);
    }
}
