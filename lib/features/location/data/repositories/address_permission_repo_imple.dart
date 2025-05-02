import 'package:flutter/material.dart';
import 'package:flutter_base/core/constants/app_routes.dart';
import 'package:flutter_base/features/location/domain/repositories/address_permission_repo.dart';
import 'package:flutter_base/features/permissions/data/model/address_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';

class AddressPermissionRepoImple implements AddressPermissionRepo {
  @override
  Future<Address?> requestLocationPermission(context) async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Reverse geocoding to get address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks.first;
      Address currentAddress = Address(
          placeName:
          "${place.country}-${place.administrativeArea}-${place.locality}",
          latitude: position.latitude,
          longitude: position.longitude,
          description:
          "${place.country}-${place.administrativeArea}-${place.locality}");
      print("current address ${currentAddress.placeName}");
      print({
        'latitude': position.latitude,
        'longitude': position.longitude,
        'address': {
          'street': place.street,
          'locality': place.locality, // City/town
          'administrativeArea': place.administrativeArea, // State/province
          'country': place.country,
          'postalCode': place.postalCode,

          'fullAddress':
          '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}',
        },
      });
      context.go(notificationPermissionScreenRoute);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission granted")),
      );
      context.go(notificationPermissionScreenRoute);
      return currentAddress;
    } else if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission denied")),
      );
      return null;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
      return null;
    }
  }

  static Future<Address> getCurrentLocation(context) async {
    try {
      // Check and request location permissions
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        print("this is Request permission ${permission.name}");

        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }else{
          context.go(notificationPermissionScreenRoute);
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied');
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Reverse geocoding to get address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks.first;
      Address currentAddress = Address(
          placeName:
              "${place.country}-${place.administrativeArea}-${place.locality}",
          latitude: position.latitude,
          longitude: position.longitude,
          description:
              "${place.country}-${place.administrativeArea}-${place.locality}");
      print("current address ${currentAddress.placeName}");
      print({
        'latitude': position.latitude,
        'longitude': position.longitude,
        'address': {
          'street': place.street,
          'locality': place.locality, // City/town
          'administrativeArea': place.administrativeArea, // State/province
          'country': place.country,
          'postalCode': place.postalCode,

          'fullAddress':
              '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}',
        },
      });
      context.go(notificationPermissionScreenRoute);
      return currentAddress;
    } catch (e) {
      throw Exception('Failed to get location: $e');
    }
  }

}
/*
*  {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'address': {
          'street': place.street,
          'locality': place.locality, // City/town
          'administrativeArea': place.administrativeArea, // State/province
          'country': place.country,
          'postalCode': place.postalCode,
          "siblo": place.subLocality,
          'fullAddress':
              '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}',
        },
      }*/