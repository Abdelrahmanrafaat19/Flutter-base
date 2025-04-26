import 'package:flutter/cupertino.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';

class TagItem extends StatelessWidget {
  final String tagName;
  const TagItem({super.key, required this.tagName});

  @override
  Widget build(BuildContext context) {
    return Text(tagName,style: AppTheme.styleWithTextWhiteAdelleSansExtendedFonts14w500,);
  }
}
