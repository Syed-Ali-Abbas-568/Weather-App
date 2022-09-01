class WeatherDataHourly {
  List<Hourly> hourly;
  WeatherDataHourly({required this.hourly});

  factory WeatherDataHourly.fromJson(Map<String, dynamic> json) =>
      WeatherDataHourly(
          hourly:
              List<Hourly>.from(json['hourly'].map((e) => Hourly.fromJson(e))));
}

class Hourly {
  dynamic dt;
  dynamic temp;
  dynamic feelsLike;
  dynamic pressure;
  dynamic humidity;
  dynamic dewPoint;
  dynamic uvi;
  dynamic clouds;
  dynamic visibility;
  dynamic windSpeed;
  dynamic windDeg;
  dynamic windGust;
  List<Weather>? weather;
  dynamic pop;

  Hourly({
    this.dt,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.pop,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        dt: json['dt'] as dynamic,
        temp: json['temp'] as dynamic,
        feelsLike: json['feels_like'] as dynamic,
        pressure: json['pressure'] as dynamic,
        humidity: json['humidity'] as dynamic,
        dewPoint: json['dew_point'] as dynamic,
        uvi: json['uvi'] as dynamic,
        clouds: json['clouds'] as dynamic,
        visibility: json['visibility'] as dynamic,
        windSpeed: json['wind_speed'] as dynamic,
        windDeg: json['wind_deg'] as dynamic,
        windGust: json['wind_gust'] as dynamic,
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
        pop: (json['pop'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temp': temp,
        'feels_like': feelsLike,
        'pressure': pressure,
        'humidity': humidity,
        'dew_point': dewPoint,
        'uvi': uvi,
        'clouds': clouds,
        'visibility': visibility,
        'wind_speed': windSpeed,
        'wind_deg': windDeg,
        'wind_gust': windGust,
        'weather': weather?.map((e) => e.toJson()).toList(),
        'pop': pop,
      };
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;
  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json['id'] as int?,
        main: json['main'] as String?,
        description: json['description'] as String?,
        icon: json['icon'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'main': main,
        'description': description,
        'icon': icon,
      };
}
