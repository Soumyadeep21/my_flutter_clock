import 'package:flutter/material.dart';
import 'package:ninja_clock/components/weather_tile.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({
    @required this.temperature,
    @required this.temperatureHigh,
    @required this.temperatureLow,
    @required this.condition,
  });
  final String temperature;
  final String temperatureHigh;
  final String temperatureLow;
  final String condition;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Text(
              temperature,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: <Widget>[
              WeatherTile(
                leading: Icon(Icons.arrow_upward),
                title: temperatureHigh,
              ),
              WeatherTile(
                leading: Icon(Icons.arrow_downward),
                title: temperatureLow,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.0,bottom: 6.0),
            child: Text(condition.toUpperCase()),
          )
        ],
      ),
    );
  }
}