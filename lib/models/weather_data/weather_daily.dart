class WeatherDataDaily {
  List<Daily> daily;
  WeatherDataDaily({required this.daily});

  factory WeatherDataDaily.fromJson(Map<String, dynamic> json) =>
      WeatherDataDaily(
          daily: List<Daily>.from(json['daily'].map((e) => Daily.fromJson(e))));
}

class Daily {
  int? dt;

  Temp? temp;

  List<Weather>? weather;
  int? clouds;
  double? pop;
  double? uvi;
  double? rain;

  Daily({
    this.dt,
    this.temp,
    this.weather,
    this.clouds,
    this.pop,
    this.uvi,
    this.rain,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        dt: json['dt'] as int?,
        temp: json['temp'] == null
            ? null
            : Temp.fromJson(json['temp'] as Map<String, dynamic>),
        weather: (json['weather'] as List<dynamic>?)
            ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
        clouds: json['clouds'] as int?,
        pop: (json['pop'] as num?)?.toDouble(),
        uvi: (json['uvi'] as num?)?.toDouble(),
        rain: (json['rain'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temp': temp?.toJson(),
        'weather': weather?.map((e) => e.toJson()).toList(),
        'clouds': clouds,
        'pop': pop,
        'uvi': uvi,
        'rain': rain,
      };
}

class Temp {
  double? day;
  double? min;
  double? max;
  double? night;
  double? eve;
  double? morn;

  Temp({this.day, this.min, this.max, this.night, this.eve, this.morn});

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        day: (json['day'] as num?)?.toDouble(),
        min: (json['min'] as num?)?.toDouble(),
        max: (json['max'] as num?)?.toDouble(),
        night: (json['night'] as num?)?.toDouble(),
        eve: (json['eve'] as num?)?.toDouble(),
        morn: (json['morn'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'day': day,
        'min': min,
        'max': max,
        'night': night,
        'eve': eve,
        'morn': morn,
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
