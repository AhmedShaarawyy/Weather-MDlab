
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_final/screens/location_screen.dart';
import 'package:weather_final/services/weather.dart';



class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    var weatherData = await WeatherModel().getWeatherData();
    await Future.delayed(const Duration(seconds: 5));

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Company Logo
            SvgPicture.asset('images/dark-logo.svg'),
            const SizedBox(height: 20),

            // Company Name
            const SizedBox(height: 10),

            // Loading Indicator
            const SpinKitFoldingCube(
              color: Color(0xFF162D47),
              size: 50.0,
            ),

            const SizedBox(height: 20),

            // Loading Message
            const Text(
              'Fetching Weather Data...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF162D47),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
