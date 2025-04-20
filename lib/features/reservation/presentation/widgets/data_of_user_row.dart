import 'package:flutter/material.dart';

import '../../../../core/Theme/app_theme.dart';

class DataOfUserRow extends StatelessWidget {
  final String title,value;
  const DataOfUserRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style:  AppTheme.style15W400codeColorA3A3A3,),
        Text(value, style:  AppTheme.style15W400codeColorA3A3A3.copyWith(color: AppTheme.codeColor525252),)
      ],
    );
  }
}
