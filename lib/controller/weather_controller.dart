import 'package:geocoding/geocoding.dart' as geocode;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weather_app/api/fetch_weather.dart';
import 'package:weather_app/models/complete/complete_weather_data.dart';

class WeatherController {
  double? latitude = 31.4968; //default longitude and latitude
  double? longitude = 74.357;
  bool _isLoading = false;
  Location location = Location();

  // bool get isLoading => _isLoading;

  CompleteWeather? weatherData;

  Future<bool> updateWeather(String address) async {
    List<geocode.Location> locations =
        await geocode.locationFromAddress(address);
    if (locations.isEmpty == false) {
      _isLoading = true;

      final prefs = await SharedPreferences.getInstance();
      final bool? exist = prefs.getBool('exist');

      if (exist == null || exist == false) {
        await prefs.setDouble('latitude', latitude!);
        await prefs.setDouble('longitude', longitude!);
        await prefs.setBool("exist", true);
      }

      latitude = locations.first.latitude;
      longitude = locations.first.longitude;

      weatherData = await FetchWeatherAPI()
          .processData(latitude, longitude)
          .then((value) {
        _isLoading = false;
        return value;
      });

      return true;
    } else {
      return false;
    }
  }

  Future<void> reset() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? exist = prefs.getBool('exist');
    if (exist == true) {
      _isLoading = true;
      latitude = prefs.getDouble('latitude');
      longitude = prefs.getDouble('longitude');
      weatherData = await FetchWeatherAPI()
          .processData(latitude, longitude)
          .then((value) {
        _isLoading = false;
        return value;
      });

      await prefs.setBool("exist", false);
      _isLoading = false;
    }
  }

  Stream<bool> checkLoading() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));

      yield _isLoading;
    }
  }

  Future<void> checkData() async {
    _isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    final bool? exist = prefs.getBool('exist');

    if (exist == null || exist == false) {
      await getLocation().then(
        (value) => _isLoading = false,
      );
    } else {
      latitude = prefs.getDouble('latitude');
      longitude = prefs.getDouble('longitude');
      await getLocation().then(
        (value) => _isLoading = false,
      ); //the case in which the location is update on the go

    }
  }

  Future<void> getLocation() async {
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

    locationData = await location.getLocation();
    latitude = locationData.latitude;
    longitude = locationData.longitude;

    weatherData =
        await FetchWeatherAPI().processData(latitude, longitude).then((value) {
      return value;
    });
  }
}
