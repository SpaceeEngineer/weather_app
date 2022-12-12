import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_phone_program/model/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:my_phone_program/model/weather_data_current.dart';
import 'package:my_phone_program/model/weather_data_daily.dart';
import 'package:my_phone_program/model/weather_data_hourly.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    print(jsonString);
    weatherData = WeatherData(
        WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString),
        WeatherDataDaily.fromJson(jsonString)
    );

    return weatherData!;
  }
}

String apiURL(var lat, var lon) {
  String API = dotenv.env['OPEN_WEATHER_MAP_API_KEY'] ?? '';
  String url;

  url = 'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&exclude=minutely&appid=$API&units=metric';
  return url;
}