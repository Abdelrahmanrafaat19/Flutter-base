import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';

class AddressItem extends StatelessWidget {
  final String addressName, addressDiscribtion;
  const AddressItem(
      {super.key, required this.addressName, required this.addressDiscribtion});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: SVGIcons.localSVG(
                  "assets/images/sendlocation.svg",
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                addressName,
                style: AppTheme.fontStyle24W70022252BColor.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: "cairepro"),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            addressDiscribtion,
            style: AppTheme.fontStyle24W70022252BColor.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppTheme.appGrey7,
            ),
          )
        ],
      ),
    );
  }
}
