import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Theme/app_theme.dart';
import '../constants/constants.dart';

class AppButton extends StatelessWidget {
  final double? width;
  final double? height;
  final bool? enabled;
  final VoidCallback onPress;
  final String? text;
  final Widget? child;
  final Color? backColor;
  final bool? outlined;
  final double? strokeWidth;
  final BorderRadiusDirectional? radius;
  final bool? isCircle;
  const AppButton(
      {Key? key,
      this.enabled = true,
      required this.onPress,
      this.backColor,
      this.text,
      this.child,
      this.width,
      this.height,
      this.radius,
      this.outlined,
      this.strokeWidth,
      this.isCircle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FadeTransition(
        opacity: AlwaysStoppedAnimation(1.0),
        child: outlined == true
            ? OutlinedButton(
                onPressed: enabled! ? onPress : null,
                style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        color: backColor ?? AppTheme.mainAppColor,
                        width: strokeWidth ?? 1),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          radius ?? BorderRadius.circular(defaultButtonRadius),
                    )),
                child: child ??
                    Text(text!,
                        style: TextStyle(
                            color: outlined == true ? backColor : Colors.white,
                            fontSize: 14.sp,
                            fontFamily: "cairepro")),
              )
            : ElevatedButton(
                onPressed: enabled! ? onPress : null,
                style: ButtonStyle(
                  shape: isCircle == true
                      ? MaterialStateProperty.all(const CircleBorder())
                      : MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: radius ?? BorderRadius.circular(10))),
                  backgroundColor: MaterialStateProperty.all(enabled == true
                      ? backColor ?? AppTheme.mainAppColor
                      : AppTheme.appGrey2),
                ),
                child: child ??
                    Text(text!,
                        style: TextStyle(
                          color: enabled == true ? Colors.white : Colors.black,
                          fontSize: 14,
                          fontFamily: "cairepro",
                        )),
              ),
      ),
    );
  }
}
