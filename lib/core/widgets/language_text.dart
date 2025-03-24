import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Theme/app_theme.dart';
import '../localization/Keys.dart';
import '../localization/LanguageProvider.dart';
import '../localization/LanguageType.dart';

class LanguageText extends ConsumerStatefulWidget {
  const LanguageText({super.key});

  @override
  ConsumerState<LanguageText> createState() => _LanguageTextState();
}

class _LanguageTextState extends ConsumerState<LanguageText> {
  @override
  Widget build(BuildContext context) {
    final isEnglishLang = ref.watch(langProvider.notifier).isEnglish;
    return Center(
      child: InkWell(
        onTap: (){
          changeLang(isEnglishLang);
        },
        child: Text(
          isEnglishLang ? context.tr(englishKey) : context.tr(arabicKey),
          style: AppTheme
              .styleWithTextBlackAdelleSansExtendedFonts16w400,
        ),
      ),
    );
  }
  void changeLang(bool isEnglishLang) {
    ref.read(langProvider.notifier).fetchLocale(isEnglishLang ? LanguageType.ar : LanguageType.en);
  }
}

