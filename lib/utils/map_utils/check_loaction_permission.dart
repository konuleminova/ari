import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void checkPermissionLocation({BuildContext context, Function onSuccess}) {
  Geolocator.checkPermission().then((permission1) {
    if (permission1 == LocationPermission.deniedForever) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Location permissions are permantly denied, we cannot request permissions.Please go to settings and turn on location permission.')),
      );
    } else {
      Geolocator.requestPermission().then((permission) {
        if (permission == LocationPermission.denied) {
          if (permission != LocationPermission.whileInUse &&
              permission != LocationPermission.always) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      "Location permissions are denied. Please accept permission to see payment details.")),
            );
          }
        } else if (permission == LocationPermission.whileInUse||permission==LocationPermission.always) {
          onSuccess();
        }
      });
    }
  });
}
