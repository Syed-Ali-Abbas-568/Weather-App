import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:weather_app/api/api_key.dart';
import 'package:weather_app/models/complete/complete_weather_data.dart';
import 'package:weather_app/models/weather_data/weather_current.dart';
import 'package:weather_app/models/weather_data/weather_daily.dart';
import 'package:weather_app/models/weather_data/weather_hourly.dart';

class FetchWeatherAPI {
  CompleteWeather? weatherData;

  //processing the data to json

  Future<CompleteWeather> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));

    if (response.statusCode == 200) {
    } else {
      log("ERROR OCCURED");
    }

    var jsonString = jsonDecode(response.body);
    weatherData = CompleteWeather(
      WeatherDataCurrent.fromJson(jsonString),
      WeatherDataHourly.fromJson(jsonString),
      WeatherDataDaily.fromJson(jsonString),
    );

    return weatherData!;
  }
}

String apiURL(var lat, var long) {
  String url;
  url =
      "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$long&appid=$apikey&units=metric&exclude=minutely";
  log("URL= $url");
  return url;
}
