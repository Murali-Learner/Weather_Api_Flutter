import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiResponse {
  Map<String, dynamic> data = {
    "weather": [
      {"description": "haze", "icon": "50d"}
    ],
    "name": "Delhi",
    "main": {"temp": 303.2, "pressure": 1012, "humidity": 37}
  };

  Future apiResponse(String cityName) async {
    String apiKey = '34f1c45eaa110091273e7ed0e38cc698';
    var client = http.Client();

    try {
      final response = await client.get(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey');
      final jsonData = json.decode(response.body);

      return WeatherData.fromJson(jsonData);
    } catch (e) {
      print(e);
      return [];
    }
  }
}

class TempMain {
  final double temperature;
  final int pressure;
  final int humidity;

  TempMain({
    required this.temperature,
    required this.pressure,
    required this.humidity,
  });
  factory TempMain.fromJson(Map<String, dynamic> main) {
    final temperature = main['temp'];
    final pressure = main['pressure'];
    final humidity = main['humidity'];

    return TempMain(
        temperature: temperature, pressure: pressure, humidity: humidity);
  }
}

class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({
    required this.description,
    required this.icon,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];

    return WeatherInfo(description: description, icon: icon);
  }
}

class WeatherData {
  final String cityName;
  final WeatherInfo weatherInfo;
  final TempMain mainInfo;

  WeatherData({
    required this.cityName,
    required this.weatherInfo,
    required this.mainInfo,
  });
  // String get iconUrl {
  //   return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  // }

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final _cityName = json['name'];
    print(_cityName);
    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);
    final mainInfoJson = json['main'];
    final mainInfo = TempMain.fromJson(mainInfoJson);

    print(weatherInfo.description);
    print(weatherInfo.icon);
    print(mainInfo.temperature);
    print(mainInfo.humidity);

    return WeatherData(
      cityName: _cityName,
      weatherInfo: weatherInfo,
      mainInfo: mainInfo,
    );
  }
}
//   "https://api.openweathermap.org/data/2.5/weather?q=India&appid=34f1c45eaa110091273e7ed0e38cc698"
 
/* 

{coord: {lon: 77.2167, lat: 28.6667},
 weather: [{id: 721, main: Haze, description: haze, icon: 50d}],
  base: stations, 
  main: {temp: 303.2, feels_like: 302.57, temp_min: 303.2, temp_max: 303.2, pressure: 1012, humidity: 37}, 
  visibility: 5000, 
  wind: {speed: 3.6, deg: 150},
   clouds: {all: 20},
   dt: 1634983036, 
   sys: {type: 1, id: 9165, country: IN, sunrise: 1634950605, sunset: 1634991234},
    timezone: 19800,
    id: 1273294, 
    name: Delhi,
     cod: 200}


*/