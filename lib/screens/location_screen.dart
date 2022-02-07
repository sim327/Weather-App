import 'package:clima_app/screens/loading_screen.dart';
import 'package:clima_app/services/ulocation.dart';
import 'package:flutter/material.dart';
import 'package:clima_app/utilities/constants.dart';
import 'dart:convert';
import 'package:clima_app/services/weather.dart';
import 'city_screen.dart';
import 'package:clima_app/services/networking.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String key = 'c33b322e2502736e8c8508e67fa756e1';
  int Condition;
  String location_name;
  WeatherModel weatherModel = WeatherModel();
  String weatherIcon;
  int temperature;
  String tempMsg;
  @override
  void initState() {
    super.initState();
    // dynamic data = widget.locationWeather;
    // print("result ${widget.locationWeather}");
    updateUi(widget.locationWeather);
  }

  void updateUi(dynamic data) {
    // location_name = jsonDecode(data)['name']
    setState(() {
      Condition = json.decode(data)['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(Condition);
      double temp = json.decode(data)['main']['temp'];
      temperature = temp.toInt();
      location_name = json.decode(data)['name'];
      tempMsg = weatherModel.getMessage(temperature);
    });
    // des = jsonDecode(data)['weather'][0]['description'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      ULocation obj = ULocation();
                      await obj.getLocation();
                      var lat = obj.latitude;
                      var long = obj.longitude;
                      NetworkHelper networkHelper = await NetworkHelper(
                          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$key&units=metric');
                      var dataValue = await networkHelper.getDataValue();
                      // print("returned value $dataValue");
                      updateUi(dataValue);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedName != null) {
                        var citydata =
                            await weatherModel.getCityWeather(typedName);
                        updateUi(citydata);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$tempMsg in $location_name",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
