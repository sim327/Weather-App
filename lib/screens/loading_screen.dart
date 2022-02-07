import 'package:clima_app/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:clima_app/services/networking.dart';
import 'package:clima_app/services/ulocation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:geopoint/geopoint.dart';
// import 'package:geopoint_location/geopoint_location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double lat;
  double long;
  String key = 'c33b322e2502736e8c8508e67fa756e1';

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    ULocation obj = ULocation();
    await obj.getLocation();
    lat = obj.latitude;
    long = obj.longitude;

    getData();
  }

  Future getData() async {
    NetworkHelper networkHelper = await NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$key&units=metric');
    var dataValue = await networkHelper.getDataValue();
    // print("returned value $dataValue");
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: dataValue);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
