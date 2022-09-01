import 'package:flutter/material.dart';

import 'controller/weather_controller.dart';

const TextStyle mainHeading = TextStyle(
  fontSize: 120,
);

const TextStyle cityHeading = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.w400,
);

TextStyle searchLabel = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w400,
  color: Colors.grey.shade600,
);

const TextStyle sevenDayLabel = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);

WeatherController obj = WeatherController();
