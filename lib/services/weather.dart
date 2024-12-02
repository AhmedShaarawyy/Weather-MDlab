
import 'package:weather_final/services/networking.dart';

import 'location.dart';

const apiKey = '2923d16c93bedc13004f6aa628ad39b3';
const openWeatherMapURL = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkeHelper networkhelper = NetworkeHelper(
        "$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric");

    var weather = await networkhelper.getData();
    return weather;
  }

  Future<dynamic> getWeatherData() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkeHelper networkhelper = NetworkeHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkhelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

// Map for weather icons
//   Map<int, String> weatherIcons = {
//   300: '🌩',
//   400: '🌧',
//   600: '☔️',
//   700: '☃️',
//   800: '☀️',
//   804: '☁️',
// };

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
