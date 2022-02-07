import 'package:clima_app/services/networking.dart';

class WeatherModel {
  String apikey = 'c33b322e2502736e8c8508e67fa756e1';
  Future<dynamic> getCityWeather(String cityname) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$apikey&units=metric';
    NetworkHelper obj = NetworkHelper(url);
    var dataValue = await obj.getDataValue();
    return dataValue;
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
