import 'package:flutter/material.dart';
import 'package:location/location.dart';

class ULocation {
  double latitude;
  double longitude;

  Future getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print("allowed");
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print("allowed");
      }
    }
    _locationData = await location.getLocation();

    latitude = _locationData.latitude;
    longitude = _locationData.longitude;
    print('lat $latitude');
  }
}
