import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherIconWidget extends StatelessWidget {
  final String iconCode;
  final double height, width;

  const WeatherIconWidget({super.key, required this.iconCode, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Image.network('https://openweathermap.org/img/wn/$iconCode@4x.png', width: width.w, height: height.h);
  }
}
