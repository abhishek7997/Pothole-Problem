import 'package:flutter/material.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class PotHole with ChangeNotifier {
  final String id;
  String roughGPSLocation;
  String address;
  File image;
  Position currentPosition;
  bool isFixed = false;

  PotHole({
    this.id,
    this.currentPosition,
  });

  String get Id => id;
  String get RoughGPSLocation => roughGPSLocation;
  String get Address => address;
  File get Image => image;
  Position get CurrentPosition => currentPosition;
  double get Latitude => currentPosition.latitude;
  double get Longitude => currentPosition.longitude;

  getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = placemarks[0];
      address = "${place.locality}, ${place.postalCode}, ${place.country}";
    } catch (e) {
      print(e);
    }
  }

  // Setters

  set setPosition(Position pos) {
    currentPosition = pos;
    getAddressFromLatLng();
    notifyListeners();
  }
}
