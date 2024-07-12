import 'package:flutter/services.dart';

class LocationService {
  static const platform = MethodChannel('com.zachary/location');

  Future<String?> getLocation() async {
    try {
      final location = await platform.invokeMethod<String>('getLocation');
      return location;
    } on PlatformException catch (e) {
      print("Failed to get location: '${e.message}'.");
      return null;
    }
  }
}
