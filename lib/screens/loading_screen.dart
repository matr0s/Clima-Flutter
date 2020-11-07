import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/location.dart';
import '../services/networking.dart';

import 'location_screen.dart';

const kApiKey = '69060ed4df9937556570f4ec99d0ddff';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  // Init State running every start of the App
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  // Method we need for the first launch of the App
  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper(
        url:
            'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=$kApiKey');
    var weatherData = await networkHelper.getData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen();
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
