import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:weather_final/screens/city_screen.dart';
import 'package:weather_final/services/weather.dart';
import 'package:weather_final/utilities/constants.dart';

//import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int? temprature;
  String? weatherIcon;
  String? cityName;
  String? messege;
  @override
  void initState() {
    super.initState();
    updateUi(widget.locationWeather);
  }

  void updateUi(dynamic weatherData) {
    if (weatherData == null) {
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        title: 'Location unavailable',
        message: 'Unable to fetch weather data.',
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.black,
        icon: const Icon(Icons.error, color: Colors.white, size: 28),
      ).show(context);
      return;
    }

    setState(() {
      double temp = weatherData['main']['temp'];
      temprature = temp.toInt();
      messege = weather.getMessage(temprature!);
      int condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/stars.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getWeatherData();
                      updateUi(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    child: const Text('MD LABS'),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName =
                          await Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const CityScreen();
                        },
                      ));
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUi(weatherData);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temprature °',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(
                  "$messege in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
