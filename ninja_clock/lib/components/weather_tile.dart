import 'package:flutter/material.dart';

class WeatherTile extends StatelessWidget {
  const WeatherTile({
    @required this.title,
    this.leading,
  });

  final String title;
  final Widget leading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0
      ),
      child: Row(
        children: <Widget>[leading ?? SizedBox(), Text(title)],
      ),
    );
  }
}