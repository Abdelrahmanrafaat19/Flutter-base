import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';

class AddressItem extends StatelessWidget {
  final String addressName, addressDiscribtion;
  final void Function()? onTap;
  const AddressItem(
      {super.key, required this.addressName, required this.addressDiscribtion, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
                Expanded(
                  child: Text(
                    addressName,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.fontStyle24W70022252BColor.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "cairepro"),
                  ),
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
      ),
    );
  }
}
