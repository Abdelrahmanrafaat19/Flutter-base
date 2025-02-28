import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/assets.dart';
import 'package:flutter_svg/svg.dart';

class SVGIcons {

  static Widget itemsIcon(){
    return SvgPicture.asset(
      itemsIconSvg,
      color: Colors.white,
      width: 30,
      height: 30,
    );
  }

  static Widget searchIcon() {
    return SvgPicture.asset(searchIconPath,
        width: 20, height: 20, fit: BoxFit.scaleDown);
  }

  static Widget localSVG(String assetPath, {double width = 50, double height = 50 , Color? color}) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      color: color,
    );
  }

  static Widget localImage(String assetPath, {double? width, double? height}) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
    );
  }

  Widget networkSVG(link){
    return SvgPicture.network(
      link,
      color: Colors.white,
      width: 50,
      height: 50,
    );
  }

}