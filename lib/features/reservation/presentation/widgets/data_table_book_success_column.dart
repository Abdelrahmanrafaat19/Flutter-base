import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/Theme/app_theme.dart';

class DataTableBookSuccessColumn extends StatelessWidget {
  final String title,value;
  const DataTableBookSuccessColumn({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.style16W400codeColor737373,
        ),
        SizedBox(
          height: 16.h,
        ),
        Expanded(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.style16W500codeColor525252,
          ),
        ),
      ],
    );
  }
}
