import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Constants/Constants.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';

class ServiceOptions extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback onClick;
  const ServiceOptions({super.key, required this.icon, required this.title, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onClick.call();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              color: AppTheme.appGrey19,
              borderRadius: BorderRadius.all(Radius.circular(defaultButtonRadius))
            ),
            child: Center(
              child: icon,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: AppTheme.styleWithTextWhiteAdelleSansExtendedFonts14w400,
          )
        ],
      ),
    );
  }
}
