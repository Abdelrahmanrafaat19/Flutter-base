import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/app_routes.dart';
import 'package:flutter_base/core/widgets/custom_app_bar.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_base/features/location/data/address_model.dart';
import 'package:flutter_base/features/location/domain/address_storage.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/Keys.dart';
import '../../widgets/address_item.dart';
import '../../widgets/search_field_widget.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  List<String> searchResults = ['Madint Nasr', 'EL-10 mn ramadan'];
  final TextEditingController _addressController = TextEditingController();
  List<Address> _addresses = [];

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  void _loadAddresses() async {
    List<Address> addresses = await AddressStorage.getAddresses();
    setState(() {
      _addresses = addresses;
    });
  }

  void _saveAddress() async {
    if (_addressController.text.isEmpty) return;

    Address newAddress = Address(
      placeName: _addressController.text,
      latitude: 0.0, // Default latitude (replace with actual value if needed)
      longitude: 0.0,
      // Default longitude (replace with actual value if needed)
    );

    await AddressStorage.addAddress(newAddress);
    _addressController.clear();
    _loadAddresses();
  }

  // Clear all saved addresses
  void _clearAddresses() async {
    await AddressStorage.clearAddresses();
    setState(() {
      _addresses.clear();
    });
  }

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
            SearchFieldWidget(
              controller: _addressController,

              searchClick: () {
                _saveAddress();
                // context.go(mainScreenRoute);
              },
            ),
            /*  TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Enter Address',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: _saveAddress,
              child: Text('Save Address'),
            ), */
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
              child: _addresses.isEmpty
                  ? Center(child: Text('No addresses saved.'))
                  : ListView.builder(
                      itemCount: _addresses.length,
                      itemBuilder: (context, index) {
                        Address address = _addresses[index];
                        return AddressItem(
                          addressName: address.placeName,
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
