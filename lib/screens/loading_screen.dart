import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // Init State running every start of the App
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  // Method we need for the first launch of the App
  void getLocationData() async {
    WeatherModel weatherLocation = WeatherModel();
    var weatherData = await weatherLocation.getWeatherLocation();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));
  }

  // Just empty Scaffold for the Loading Interface where we load initState
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDualRing(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
