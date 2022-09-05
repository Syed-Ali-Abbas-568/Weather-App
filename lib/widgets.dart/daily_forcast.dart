import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:weather_app/constants.dart';

class DailyForcast extends StatelessWidget {
  const DailyForcast({Key? key, required this.vertical}) : super(key: key);

  final bool vertical;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: vertical
          ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DailyList(
                    vertical: true,
                    main: obj.weatherData?.daily.daily[index].weather![0].main
                        as String,
                    tempMin: obj.weatherData?.daily.daily[index].temp!.min,
                    tempMax: obj.weatherData?.daily.daily[index].temp!.max,
                    timeStamp: obj.weatherData?.daily.daily[index].dt,
                    index: index,
                    weatherIcon:
                        "${obj.weatherData?.daily.daily[index].weather![0].icon!}",
                  ),
                );
              },
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DailyList(
                    main: "",
                    vertical: false,
                    tempMin: obj.weatherData?.daily.daily[index].temp!.min,
                    tempMax: obj.weatherData?.daily.daily[index].temp!.max,
                    timeStamp: obj.weatherData?.daily.daily[index].dt,
                    index: index,
                    weatherIcon:
                        "${obj.weatherData?.daily.daily[index].weather![0].icon!}",
                  ),
                );
              },
            ),
    );
  }
}

class DailyList extends StatelessWidget {
  final dynamic tempMin;
  final dynamic tempMax;
  final int index;
  final dynamic timeStamp;
  final String weatherIcon;
  final bool vertical;
  final String main;
  const DailyList({
    Key? key,
    required this.main,
    required this.vertical,
    required this.timeStamp,
    required this.tempMin,
    required this.tempMax,
    required this.weatherIcon,
    required this.index,
  }) : super(key: key);

  String getTime(final timeStamp, int index) {
    if (index == 0) {
      return "Today";
    } else if (index == 1) {
      return "Tommorow";
    } else {
      DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
      String newTime = DateFormat('MMMEd').format(time);
      return newTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (vertical == false) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            getTime(timeStamp, index),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Image.asset(
            "assets/icons/$weatherIcon.png",
            width: 40,
            height: 30,
          ),
          Text(
            "Min:\n ${tempMin.toStringAsFixed(1)}°C",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "Max:\n ${tempMax.toStringAsFixed(1)}°C",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/icons/$weatherIcon.png",
            width: 40,
            height: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "${getTime(timeStamp, index)} - $main",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "${tempMin.toStringAsFixed(1)}°C / ${tempMax.toStringAsFixed(1)}°C",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );
    }
  }
}
