import 'dart:developer';

import 'package:location/location.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/api/fetch_weather.dart';
import 'package:weather_app/models/complete/complete_weather_data.dart';

class WeatherController {
  double? latitude = 31.4968; //default longitude and latitude
  double? longitude = 74.357;
  bool _isLoading = true;
  Location location = Location();

  CompleteWeather? weatherData;

  Stream<bool> checkLoading() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield _isLoading;
    }
  }

  void checkData() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? exist = prefs.getBool('exist');

    if (exist == null || exist == false) {
      getLocation();
    } else {
      latitude = prefs.getDouble('latitude');
      longitude = prefs.getDouble('longitude');
      getLocation(); //the case in which the location is update on the go

    }
  }

  void getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    //so basically this checks if the location services are active and if not asks them to activate location
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    //basically checks if the location permission was provicded or not, if not then requests for it
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    //getting the current position of the user

    locationData = await location.getLocation().then((value) {
      latitude = value.latitude;
      longitude = value.longitude;
      return value;
    });

    log("UPDATE LAT=$latitude LONG=$longitude");

    weatherData =
        await FetchWeatherAPI().processData(latitude, longitude).then((value) {
      _isLoading = false;

      return value;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('latitude', latitude!);
    await prefs.setDouble('longitude', longitude!);
    await prefs.setBool('exist', true);
  }
}
