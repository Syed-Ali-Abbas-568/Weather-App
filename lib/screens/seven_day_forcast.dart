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
    return Scaffold(
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
              Container(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height,
                    maxWidth: MediaQuery.of(context).size.width),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/7dayforecast.png",
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              const Positioned(
                top: 65,
                left: 16,
                right: 217,
                child: Text(
                  "7-Day Forcast",
                  style: sevenDayLabel,
                ),
              ),
              const Positioned(
                top: 120,
                left: 20,
                right: 20,
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: DailyForcast(
                    vertical: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
