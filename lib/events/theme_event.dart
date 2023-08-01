import 'package:equatable/equatable.dart';
// import 'package:flutter/cupertino.dart';
import 'package:weatherapp/models/weather.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeEventWeatherChanged extends ThemeEvent {
  final WeatherCondition weatherCondition;
  const ThemeEventWeatherChanged({required this.weatherCondition});

  @override
  List<Object> get props => [weatherCondition];
}