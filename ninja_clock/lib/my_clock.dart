import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:ninja_clock/components/clock_body.dart';
import 'package:ninja_clock/components/weather_details.dart';
import 'package:ninja_clock/components/weather_tile.dart';

class MyClock extends StatefulWidget {
  final ClockModel model;
  MyClock(this.model);

  @override
  _MyClockState createState() => _MyClockState();
}

class _MyClockState extends State<MyClock> with SingleTickerProviderStateMixin {
  var _now = DateTime.now();
  var _temperature = '';
  var _temperatureLow = '';
  var _temperatureHigh = '';
  var _condition = '';
  var _location = '';
  Timer _timer;
  AnimationController controller;
  Animation secondsAnimation;
  Tween<double> secondsTween;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 25),
    );
    secondsTween = Tween<double>();
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
    controller.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      _temperatureLow = widget.model.lowString;
      _temperatureHigh = widget.model.highString;
      _condition = widget.model.weatherString;
      _location = widget.model.location;
    });
  }

  void _updateTime() {
    setState(() {
      secondsTween.begin = (_now.second + _now.millisecond / 1000) ?? 0.0;
      _now = DateTime.now();
      secondsTween.end = (_now.second + _now.millisecond / 1000).toDouble();
      secondsAnimation = secondsTween.animate(CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ));
      controller.forward();
      _timer = Timer(
        Duration(milliseconds: 50),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDark ? Color(0xff080D19) : Color(0xfffbf7f5),
      child: Stack(
        children: <Widget>[
          ClockBody(
            now: _now,
            model: widget.model,
            seconds: secondsAnimation.value,
          ),
          WeatherDetails(
            temperature: _temperature,
            temperatureHigh: _temperatureHigh,
            temperatureLow: _temperatureLow,
            condition: _condition,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: WeatherTile(
              leading: Icon(
                Icons.location_on,
              ),
              title: _location,
            ),
          ),
        ],
      ),
    );
  }
}
