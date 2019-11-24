import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

final radiansPerTick = math.radians(360 / 60);
final radiansPerHour = math.radians(360 / 12);

List<Color> getSecondsColor(bool isDark) => isDark
    ? [Color(0xff2193b0), Color(0xff6dd5ed)]
    : [Color(0xffff5f6d), Color(0xffffc371)];

List<Color> getMinutesColor(bool isDark) => isDark
    ? [Color(0xff43cea2), Color(0xff185a9d)]
    : [Color(0xffffc371), Color(0xffff5f6d)];

List<Color> getHoursColor(bool isDark) => isDark
    ? [Color(0xff02aab0), Color(0xff00cdac)]
    : [Color(0xffff512f), Color(0xffdd2476)];
