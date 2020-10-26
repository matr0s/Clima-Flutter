import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
  }

  void getWeatherData() async {
    http.Response weatherResponse = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&units=metric&appid=69060ed4df9937556570f4ec99d0ddff');
    if (weatherResponse.statusCode == 200) {
      String data = weatherResponse.body;

      var decodedData = jsonDecode(data);

      double weatherTemp = decodedData['main']['temp'];
      int weatherType = decodedData['weather'][0]['id'];
      String cityName = decodedData['name'];
    } else {
      print(weatherResponse.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getWeatherData();
    return Scaffold();
  }
}
