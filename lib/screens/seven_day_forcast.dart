import 'package:flutter/material.dart';

import 'package:weather_app/constants.dart';

import 'package:weather_app/widgets.dart/daily_forcast.dart';

class Forcast extends StatefulWidget {
  const Forcast({Key? key}) : super(key: key);

  @override
  State<Forcast> createState() => _ForcastState();
}

class _ForcastState extends State<Forcast> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(255, 195, 104, 213),
              Color.fromARGB(255, 117, 49, 185)
            ]),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              fit: StackFit.expand,
              children: [
                const Positioned(
                  top: 65,
                  left: 16,
                  right: 217,
                  child: Text(
                    "7-Day Forcast",
                    style: sevenDayLabel,
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 20,
                  right: 20,
                  height: 200,
                  child: Container(
                    child: const DailyForcast(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
