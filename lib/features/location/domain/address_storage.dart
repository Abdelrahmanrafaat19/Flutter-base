import 'package:flutter_base/core/constants/constants.dart';
import 'package:flutter_base/features/location/data/address_model.dart';
import 'package:flutter_base/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../restaurant_details/data/models/location_model.dart';
import '../../permissions/data/model/address_model.dart';

class AddressStorage {
  static const String _key = 'searched_addresses';

  // Save list of Address objects
  static Future<void> saveAddresses(List<Address> addresses) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList =
        addresses.map((address) => jsonEncode(address.toJson())).toList();
    await prefs.setStringList(_key, jsonList);
  }

  // Get list of saved Address objects
  static Future<List<Address>> getAddresses() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(_key);
    if (jsonList == null) return [];

    return jsonList
        .map((jsonStr) => Address.fromJsonWithLatLng(jsonDecode(jsonStr),0.0,0.0),)
        .toList();
  }

  // Add a new address (avoid duplicates)
  static Future<void>addAddress(Address address) async {
    List<Address> addresses = await getAddresses();
    if (!addresses.any((a) => a.placeName == address.placeName)) {
      addresses.add(address);
      await saveAddresses(addresses);
    }
  }

  // Clear all saved addresses
  static Future<void> clearAddresses() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  static void saveUserCurrentLocation(Address address){
    prefs.setString(USER_LOCATION_KEY, json.encode(address.toJson()));
    print("clint location model saved $address");
  }

  static Address? checkIfUserHasLocation(){
    var addressJson = prefs.getString(USER_LOCATION_KEY);
    Address? currentAddressLocation = addressJson != null ? Address.fromJson(jsonDecode(addressJson??"")) : null;
    return currentAddressLocation;
  }

  static Future<LocationModel?> getUserLocation() async {

    final userAddress = AddressStorage.checkIfUserHasLocation();
    print("aasdfasdfasd ${userAddress?.toJson()}");
    if (userAddress != null) {
      return LocationModel(lat: userAddress.latitude.toString(), lon: userAddress.longitude.toString());
    }
    return null;
  }
}
