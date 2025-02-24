import 'package:flutter_base/features/location/data/address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
        .map((jsonStr) => Address.fromJson(jsonDecode(jsonStr)))
        .toList();
  }

  // Add a new address (avoid duplicates)
  static Future<void> addAddress(Address address) async {
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
}
