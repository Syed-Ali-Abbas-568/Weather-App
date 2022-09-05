import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import 'package:weather_app/constants.dart';

import 'package:weather_app/screens/seven_day_forcast.dart';
import 'package:weather_app/widgets.dart/daily_forcast.dart';
import 'package:weather_app/widgets.dart/hourly_display.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final aqi = TextEditingController();
  final FindLocation = TextEditingController();
  String? city;
  String? mainWeather;
  bool error = false;
  bool back_button = false;

  @override
  void initState() {
    obj.checkData();
    super.initState();
  }

  void getCityName() async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(obj.latitude!, obj.longitude!);
    Placemark place = placemark[0];
    setState(() {
      city = " ${place.locality}, ${place.administrativeArea}";
    });
  }

  @override
  Widget build(BuildContext context) {
    aqi.text = "AQI 13";

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: StreamBuilder<bool>(
        stream: obj.checkLoading(),
        builder: (context, snapshot) {
          log("value of snapshot is ${snapshot.data}");
          if (snapshot.data == false) {
            getCityName();
            mainWeather = obj.weatherData?.current.current.weather![0].main;

            return SingleChildScrollView(
              child: SizedBox(
                height: 1300,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 1256,
                    ),
                    Container(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height,
                          maxWidth: MediaQuery.of(context).size.width),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              selectImage(),
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    const Positioned(
                      top: 420,
                      left: 20,
                      right: 20,
                      child: HourlyDataWidget(),
                    ),
                    Positioned(
                      top: 590,
                      left: 20,
                      right: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(125, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 200,
                        width: 200,
                        child: const DailyForcast(
                          vertical: true,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 22,
                      right: 21,
                      top: 45,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            error
                                ? "Please Enter Correct Location"
                                : city ?? 'Loading City Name',
                            style: cityHeading,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Visibility(
                                  visible: back_button,
                                  child: IconButton(
                                    onPressed: () async {
                                      obj.reset();
                                      back_button = false;
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.arrow_back),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(22, 0, 22, 0),
                                    height: 34,
                                    child: TextField(
                                      controller: FindLocation,
                                      style: searchLabel,
                                      textAlign: TextAlign.center,
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color(0xffE7E6E6),
                                        hintText: "Search Cities",
                                        alignLabelWithHint: true,
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        prefixIcon: const Icon(
                                          Icons.search_sharp,
                                          color: Colors.grey,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      onEditingComplete: () async {
                                        if (await obj
                                            .updateWeather(FindLocation.text)) {
                                          FindLocation.clear();
                                          error = false;
                                          back_button = true;
                                          setState(() {});
                                        } else {
                                          FindLocation.clear();
                                          error = true;
                                          back_button = false;
                                          setState(() {});
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 159,
                      left: 109,
                      right: 60,
                      child: SizedBox(
                        height: 225,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              obj.weatherData?.current.current.temp
                                      ?.toStringAsFixed(0) ??
                                  "Temp",
                              style: mainHeading,
                              textAlign: TextAlign.center,
                            ),
                            const Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "°C",
                                style: TextStyle(
                                  fontSize: 42,
                                  height: 3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 338,
                      left: 113,
                      right: 112,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            mainWeather ?? "Description",
                            style: const TextStyle(fontSize: 24),
                          ),
                          Container(
                            padding: const EdgeInsets.all(0),
                            height: 30,
                            width: 116,
                            child: TextField(
                              controller: aqi,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.left,
                              scrollPhysics:
                                  const NeverScrollableScrollPhysics(),
                              readOnly: true,
                              decoration: InputDecoration(
                                hintStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 24),
                                prefixIcon: const ImageIcon(
                                  AssetImage('assets/icons/aqi.png'),
                                  color: Colors.white,
                                ),
                                prefixIconColor: Colors.white,
                                hintText: "AQI 33",
                                enabled: false,
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                              ),
                              onTap: null,
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 818,
                      left: 16,
                      right: 16,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(125, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            // side: const BorderSide(width: 4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Forcast()),
                            );
                          },
                          child: const Text(
                            '7-Day Forecast',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 883,
                      left: 17,
                      right: 18,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(125, 255, 255, 255),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Real feel         ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "${obj.weatherData?.current.current.feelsLike}",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const Text(
                                    "Chance of rain",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "${obj.weatherData?.current.current.dewPoint}%",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Text(
                                    "Wind speed    ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "${obj.weatherData?.current.current.windSpeed}km/h",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Humidity    ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "${obj.weatherData?.current.current.humidity}%",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Text(
                                    "Pressure    ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "${(obj.weatherData?.current.current.pressure)! / 1000} atm",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Text(
                                    "UV Index   ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "${obj.weatherData?.current.current.uvi}",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        top: 1155,
                        left: 17,
                        right: 15,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(125, 255, 255, 255),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.remove_red_eye_outlined,
                                      color: Colors.white,
                                      size: 36.0,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Visibility",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "${obj.weatherData?.current.current.visibility / 1000} km",
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            );
          } else if (snapshot.data == true) {
            log("value of snapshot is ${snapshot.data}");
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 6.0),
            );
          } else {
            return const Center(
              child: Text(
                "Connecting to API",
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }

  String selectImage() {
    if (mainWeather == "Smoke") {
      return "assets/images/smoky.png";
    } else if (mainWeather == "Thunderstorm") {
      return "assets/images/thunderstorm.png";
    } else if (mainWeather == "Drizzle" || mainWeather == "Rain") {
      return "assets/images/rainy.png";
    } else if (mainWeather == "Snow") {
      return "assets/images/snow.jpg";
    } else if (mainWeather == "Mist") {
      return "assets/images/mist.jpg";
    } else if (mainWeather == "Clear") {
      return "assets/images/clear.png";
    } else {
      return "assets/images/cloudy.png";
    }
  }
}
