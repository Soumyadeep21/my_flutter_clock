import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:ninja_clock/components/radial_painter.dart';
import 'package:ninja_clock/constants.dart';

class ClockBody extends StatelessWidget {
  const ClockBody({
    @required DateTime now,
    @required this.model,
    @required this.seconds,
  }) : _now = now;

  final DateTime _now;
  final double seconds;
  final ClockModel model;

  int toHour(int h) => h < 12 ? h : h - 12;
  String amORpm(int h) => h < 12 ? 'AM' : 'PM';
  String timeFormatter(int t) => t < 10 ? '0$t' : t.toString();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RadialPainter(
        angleRadians: seconds * radiansPerTick,
        thickness: 5.0,
        position: 0.9,
        colors: [
          Colors.red,
          Colors.blue,
        ],
      ),
      //Minute Radial
      child: CustomPaint(
        painter: RadialPainter(
          position: 0.8,
          angleRadians: _now.minute * radiansPerTick,
          thickness: 8.0,
          colors: [
            Colors.red,
            Colors.blue,
          ],
        ),
        //Hour Radial
        child: CustomPaint(
          painter: RadialPainter(
            position: 0.7,
            angleRadians: toHour(_now.hour) * radiansPerHour +
                (_now.minute / 60) * radiansPerHour,
            thickness: 11.0,
            colors: [
              Colors.red,
              Colors.blue,
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(
                  '${timeFormatter(model.is24HourFormat ? _now.hour : toHour(_now.hour))} : ${timeFormatter(_now.minute)}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 20),
                ),
                Visibility(
                  visible: !model.is24HourFormat,
                  child: Text(
                    '${amORpm(_now.hour)}',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
