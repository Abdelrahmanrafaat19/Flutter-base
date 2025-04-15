import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/Theme/app_theme.dart';
import 'package:flutter_base/core/constants/app_routes.dart';
import 'package:flutter_base/core/widgets/custom_app_bar.dart';
import 'package:flutter_base/core/widgets/svg_icons.dart';
import 'package:flutter_base/features/location/data/address_model.dart';
import 'package:flutter_base/features/location/domain/address_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/localization/Keys.dart';
import '../../../../core/utils/location_handler.dart';
import '../../../../core/utils/permissions_handler.dart';
import '../../data/data_source/address_services.dart';
import '../../data/model/address_model.dart';
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
  final AddressService _service = AddressService();
  List<Address> _addresses = [];
  List<Address> Localeaddresses=[];
  bool _loading = false;

  LatLng? _currentLatLng;


  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }
  void _onTextChanged(String value) async {
    if (value.isEmpty) {
      setState(() => _addresses = []);
      return;
    }

    setState(() => _loading = true);
    final results = await _service.fetchSuggestions(value);
    setState(() {
      _addresses = results;
      _loading = false;
    });
  }

  void _onTapAddress(Address addr) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        '${addr.placeName} selected\nLat: ${addr.latitude}, Lng: ${addr.longitude}',
      ),
    ));
    setState(() {
      _addressController.text = addr.placeName;
      _addresses = [];
    });
  }

  void _loadAddresses() async {
      Localeaddresses = await AddressStorage.getAddresses();
    setState(() {

    });
  }

  void _saveAddress(Address address) async {
    if (_addressController.text.isEmpty) return;

    Address newAddress = Address(
      placeName: _addressController.text,
      latitude: 0.0,
      longitude: 0.0,
      description:""
    );

    await AddressStorage.addAddress(address);
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
              onChanged: _onTextChanged,
              searchClick: () {

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
            GestureDetector(
              onTap:() {

                _getLocation();
              },
              child: Container(
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
            child: /*_addresses.isEmpty*/
              //     ? Center(child: Text('No addresses saved.'))
              //     :
              ListView.builder(
                      itemCount:_addresses.isEmpty?Localeaddresses.length: _addresses.length,
                      itemBuilder: (context, index) {
                        // Address address = _addresses[index];
                        return AddressItem(
                          onTap: () {
                            if(_addresses.isEmpty){
                              _saveAddress(Localeaddresses[index]);
                              _onTapAddress(Localeaddresses[index]);
                            }else{
                              _saveAddress(_addresses[index]);
                              _onTapAddress(_addresses[index]);
                            }

                          },
                          addressName:_addresses.isEmpty?Localeaddresses[index].placeName:_addresses[index].placeName,
                          addressDiscribtion: _addresses.isEmpty?Localeaddresses[index].description:_addresses[index].description,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
  void _getLocation() async {
    if (await PermissionsHandler.checkLocationPermission()) {
      var position = await LocationHandler.getCurrentLocation();
      _currentLatLng = LatLng(position!.latitude, position.longitude);

    }
  }
}
// void _onTextChanged(String input) async {
//   if (input.isEmpty) {
//     setState(() {
//       _suggestions = [];
//     });
//     return;
//   }
//
//   final url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//
//   try {
//     final response = await _dio.get(url, queryParameters: {
//       'input': input,
//       'key': _apiKey,
//       // Optional: add location biasing or country filters here
//     });
//
//     if (response.statusCode == 200) {
//       final predictions = response.data['predictions'] as List;
//       final newSuggestions =
//       predictions.map((p) => p['description'] as String).toList();
//       print(response.data);
//       setState(() {
//         _suggestions = newSuggestions;
//       });
//     }
//   } catch (e) {
//     print('Error: $e');
//   }
// }
//
// void _onSuggestionTap(String suggestion) {
//   _addressController.text = suggestion;
//   setState(() {
//     _suggestions = [];
//   });
// }



// Future<List<String>> getPlaceSuggestionsWithDio(String input) async {
//   const apiKey = 'AIzaSyAIhooYpv80pRyeAhyNzAyb4YGCmkTUlXA';
//   final dio = Dio();
//
//   final String url =
//       'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//
//   try {
//     final response = await dio.get(url, queryParameters: {
//       'input': input,
//       'key': apiKey,
//       // Optional: add more parameters here like location, radius, etc.
//     });
//
//     if (response.statusCode == 200) {
//
//       final predictions = response.data['predictions'] as List;
//       print("this is First Location ${response.data[0]}");
//       return predictions.map((p) => p['description'] as String).toList();
//     } else {
//       throw Exception('Failed to get suggestions');
//     }
//   } catch (e) {
//     print('Error fetching place suggestions: $e');
//     return [];
//   }
// }