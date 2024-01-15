import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wether_app/models/weather_model.dart';
import 'package:wether_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('dae19ae01dd9dd04282aa416e853b374');
  Weather? _weather;

  _fetchWeather() async {
    final cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String mainCondition) {
    switch (mainCondition) {
      case 'Clouds':
      case 'Mist':
      case 'Haze':
      case 'Smoke':
      case 'Dust':
      case 'Fog':
        return 'assets/images/cloudy.json';
      case 'Rain':
      case 'Drizzle':
      case 'shower rain':
        return 'assets/images/raining.json';
      case 'Thunderstorm':
        return 'assets/images/thunder.json';
      case 'Clear':
        return 'assets/images/sunny.json';
      default:
        return 'assets/images/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.location_on,
          color: Colors.grey[500],
          size: 24.0,
        ),
        Text(
          _weather?.cityName ?? 'Loading...',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey[500],
          ),
        ),
        Lottie.asset(getWeatherAnimation(_weather?.mainCondition ?? '')),
        Text(
          '${_weather?.temperature.round()}°'?? '',
          style: TextStyle(
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey[500],
          ),
        ),
        Padding(padding: EdgeInsets.only(bottom: 24.0)),
      ]),
    );
  }
}
