import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:weather_app/constants.dart';

class DailyForcast extends StatelessWidget {
  const DailyForcast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        children: [
          ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: obj.weatherData?.daily.daily.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  // blur
                ),
                child: DailyList(
                  temp: obj.weatherData?.daily.daily[index].temp,
                  timeStamp: obj.weatherData?.daily.daily[index].dt,
                  weatherIcon:
                      "${obj.weatherData?.daily.daily[index].weather![0].icon!}",
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DailyList extends StatelessWidget {
  dynamic temp;
  dynamic timeStamp;
  String weatherIcon;

  DailyList(
      {Key? key,
      required this.timeStamp,
      required this.temp,
      required this.weatherIcon})
      : super(key: key);

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String newTime = DateFormat('MEd').format(time);
    return newTime;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Text(
            getTime(timeStamp),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Text(
          "${temp.toStringAsFixed(1)}°C",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          child: Image.asset(
            "assets/icons/$weatherIcon.png",
            width: 30,
            height: 20,
          ),
        ),
      ],
    );
  }
}
