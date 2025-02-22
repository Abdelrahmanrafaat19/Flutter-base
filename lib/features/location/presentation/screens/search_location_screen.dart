import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/widgets/custom_app_bar.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_base/features/location/presentation/widgets/address_item.dart';
import 'package:flutter_base/features/location/presentation/widgets/search_field_widget.dart';

import '../../../../core/localization/Keys.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  List<String> searchResults = ['Madint Nasr', 'EL-10 mn ramadan'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        navigated: true,
        appContext: context,
        title: context.tr(searchLocationManuallyKey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchFieldWidget(),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 16),
              child: Row(
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
                    'Use my current Location',
                    style: AppTheme.fontStyle24W70022252BColor.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: "cairepro"),
                  )
                ],
              ),
            ),
            Divider(),
            const Text(
              'Search Results',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: "cairepro",
                color: AppTheme.appGrey7,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return const AddressItem(
                    addressName: "EL-10 mn ramadan",
                    addressDiscribtion: "85 elnasr street  Rd. elaml",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
