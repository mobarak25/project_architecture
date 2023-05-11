import 'package:device_info_plus/device_info_plus.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:injectable/injectable.dart';
import 'package:location/location.dart';

abstract class GetLocationRepo {
  Future<LocationData?> getLocation();
  Future<String?> getAddress({required double lat, required double lng});
}

@LazySingleton(as: GetLocationRepo)
class GetLocationRepoImpl implements GetLocationRepo {
  @override
  Future<LocationData?> getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData? locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    await location.getLocation().then((value) {
      locationData = value;
    }).timeout(const Duration(seconds: 3), onTimeout: () {
      return null;
    });

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    return locationData ??
        (androidInfo.isPhysicalDevice
            ? null
            : LocationData.fromMap({"latitude": 23.77, "longitude": 90.89}));
  }

  @override
  Future<String?> getAddress({required double lat, required double lng}) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    String? address;

    if (androidInfo.isPhysicalDevice) {
      try {
        final List<geo.Placemark> placeMarks =
            await geo.placemarkFromCoordinates(lat, lng);

        address = "${placeMarks[0].name!}, ${placeMarks[0].subLocality!}";
      } on Exception {
        return null;
      }
    }
    return address ?? 'M S Toren, Manama Tower, Dhaka';
  }
}
