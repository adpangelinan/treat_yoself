import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_gravatar/simple_gravatar.dart';
import 'package:treat_yoself/models/models.dart';
import 'package:treat_yoself/routes.dart';
import 'package:treat_yoself/localizations/localizations.dart';
import 'package:treat_yoself/views/views.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationController extends GetxController {
  bool serviceEnabled;
  LocationPermission permission;
  Position current;
  var zip = List<String>().obs;
  var newzip;

  @override
  void onInit() async {
    super.onInit();
  }

// https://pub.dev/packages/geolocator
  Future<Position> _determinePosition() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<String> tranlateToZip() async {
    current = await _determinePosition();
    newzip =
        await placemarkFromCoordinates(current.latitude, current.longitude);

    return newzip[0].postalCode.toString();
  }
}
