// ignore_for_file: avoid_print

import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

class LocationServices {
  final Location _location;
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  LocationServices() : _location = Location();

  Future<bool> enableLocationService() async {
    try {
      _serviceEnabled = await _location.serviceEnabled();

      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
      }
    } on PlatformException catch (e) {
      print("Error Code is: ${e.code} and message: ${e.message}");
      _serviceEnabled = false;
      await enableLocationService();
    }
    return _serviceEnabled;
  }

  Future<bool> checkPermission() async {
    if (await enableLocationService()) {
      _permissionGranted = await _location.hasPermission();

      if (_permissionGranted == PermissionStatus.granted) {
        _permissionGranted = await _location.requestPermission();
      }
    }
    return _permissionGranted == PermissionStatus.granted;
  }

  Future<LocationData?> getLocatin() async {
    if (await checkPermission()) {
      final locationData = await _location.getLocation();
      return locationData;
    }
    return null;
  }

  Future<geo.Placemark?> getPlaceMark({
    required LocationData locationData,
  }) async {
    final List<geo.Placemark>? placeMarks = await geo.placemarkFromCoordinates(
      locationData.latitude!,
      locationData.longitude!,
    );
    if (placeMarks != null && placeMarks.isNotEmpty) {
      return placeMarks[0];
    }

    return null;
  }
}
