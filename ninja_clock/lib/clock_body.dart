import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:ninja_clock/constants.dart';
import 'package:ninja_clock/radial_painter.dart';

class ClockBody extends StatelessWidget {
  const ClockBody({
    @required DateTime now,
    @required this.model,
  }) : _now = now;

  final DateTime _now;
  final ClockModel model;

  int toHour(int h) => h < 12 ? h : h - 12;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RadialPainter(
        angleRadians: _now.second * radiansPerTick,
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
            child: Text(
              '${model.is24HourFormat ? _now.hour : toHour(_now.hour)}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
