import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../main.dart';
import '../constants/constants.dart';
import 'LanguageType.dart';

class LanguageProvider extends StateNotifier<Locale> {

  final Ref ref;
  LanguageProvider(this.ref) : super( Locale(prefs.getString(LANG_KEY) ?? LanguageType.ar));

  Locale _appLocale =  Locale(prefs.getString(LANG_KEY) ?? LanguageType.ar);
  bool isEnLanguage = prefs.getString(LANG_KEY) == LanguageType.en;


  Locale get appLocal => _appLocale;
  bool get isEnglish => isEnLanguage;

  fetchLocale(String? userLang) async {
    print(userLang);
    prefs.setString(LANG_KEY, userLang??LanguageType.ar);
    print(prefs.getString(LANG_KEY));

    if(userLang != null){
      _appLocale = Locale(userLang);
    }else{
      _appLocale =  const Locale(LanguageType.ar);
    }
    isEnLanguage = _appLocale ==  const Locale(LanguageType.en) ? true : false;
    print(_appLocale);
    state = _appLocale;
  }

  String changeLanguage() {
    _appLocale = _appLocale ==   const Locale(LanguageType.en) ?  const Locale(LanguageType.ar) :  const Locale(LanguageType.en);
    isEnLanguage = _appLocale ==  const Locale(LanguageType.en) ? true : false;
    state = _appLocale;
    print("Changed");
    return _appLocale.languageCode;
  }
}

final langProvider = StateNotifierProvider<LanguageProvider,Locale>((ref) => LanguageProvider(ref));