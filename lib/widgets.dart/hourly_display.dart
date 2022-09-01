import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:weather_app/constants.dart';

class HourlyDataWidget extends StatelessWidget {
  const HourlyDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(),
          alignment: Alignment.topCenter,
          child: const Text(
            "Now",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 200,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: obj.weatherData?.hourly.hourly.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              // blur
            ),
            child: HourlyDetails(
              temp: obj.weatherData?.hourly.hourly[index].temp,
              timeStamp: obj.weatherData?.hourly.hourly[index].dt,
              windSpeed: obj.weatherData?.hourly.hourly[index].windSpeed,
              weatherIcon:
                  "${obj.weatherData?.hourly.hourly[index].weather![0].icon!}",
            ),
          );
        },
      ),
    );
  }
}

class HourlyDetails extends StatelessWidget {
  HourlyDetails(
      {Key? key,
      required this.timeStamp,
      required this.temp,
      required this.weatherIcon,
      required this.windSpeed})
      : super(key: key);
  dynamic temp;
  dynamic timeStamp;
  String weatherIcon;
  dynamic windSpeed;

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String newTime = DateFormat('jm').format(time);
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ImageIcon(
              AssetImage(
                'assets/icons/arrow.png',
              ),
              color: Colors.white,
            ),
            Text(
              "${windSpeed.toStringAsFixed(1)}km/h",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        )
      ],
    );
  }
}
