import 'package:weather_app/models/weather_data/weather_current.dart';
import 'package:weather_app/models/weather_data/weather_daily.dart';
import 'package:weather_app/models/weather_data/weather_hourly.dart';

class CompleteWeather {
  final WeatherDataCurrent current;
  final WeatherDataHourly hourly;
  final WeatherDataDaily daily;

  CompleteWeather(this.current, this.hourly, this.daily);
}
