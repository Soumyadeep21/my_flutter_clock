import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:ninja_clock/radial_painter.dart';
import 'package:vector_math/vector_math_64.dart' as math;

final radiansPerTick = math.radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = math.radians(360 / 12);

class MyClock extends StatefulWidget {
  final ClockModel model;
  MyClock(this.model);

  @override
  _MyClockState createState() => _MyClockState();
}

class _MyClockState extends State<MyClock> {
  var _now = DateTime.now();
  var _temperature = '';
  var _temperatureRange = '';
  var _condition = '';
  var _location = '';
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    // Set the initial values.
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(MyClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      _temperatureRange = '(${widget.model.low} - ${widget.model.highString})';
      _condition = widget.model.weatherString;
      _location = widget.model.location;
    });
  }

  int toHour(int h) => h < 12 ? h : h - 12;

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      // Update once per second. Make sure to do it at the beginning of each
      // new second, so that the clock is accurate.
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
      print(toHour(_now.hour));
      print(_now.minute * radiansPerTick);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff0B0B1B),
      //Second Radial
      child: CustomPaint(
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
                '${widget.model.is24HourFormat ? _now.hour : toHour(_now.hour)}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
