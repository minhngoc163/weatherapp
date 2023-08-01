import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/events/theme_event.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/states/theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  //initial state
  ThemeBloc() : super(ThemeState(
    backgroundColor: Colors.lightBlue,
    textColor: Colors.white,
  )) {
    on<ThemeEventWeatherChanged>(_onThemeEventWeatherChanged);
  }

  void _onThemeEventWeatherChanged(ThemeEventWeatherChanged event,
      Emitter<ThemeState> emit) {
    final weatherCondition = event.weatherCondition;
    if (weatherCondition == WeatherCondition.clear ||
        weatherCondition == WeatherCondition.lightCloud) {
      emit(ThemeState(
        backgroundColor: Colors.yellow,
        textColor: Colors.black,
      ));
    } else if (weatherCondition == WeatherCondition.hail ||
        weatherCondition == WeatherCondition.snow ||
        weatherCondition == WeatherCondition.sleet) {
      emit(ThemeState(
        backgroundColor: Colors.lightBlue,
        textColor: Colors.white,
      ));
    } else if (weatherCondition == WeatherCondition.heavyCloud) {
      emit(ThemeState(
        backgroundColor: Colors.grey,
        textColor: Colors.black,
      ));
    } else if (weatherCondition == WeatherCondition.heavyRain ||
        weatherCondition == WeatherCondition.lightRain ||
        weatherCondition == WeatherCondition.showers) {
      emit(ThemeState(
        backgroundColor: Colors.indigo,
        textColor: Colors.white,
      ));
    } else if (weatherCondition == WeatherCondition.thunderstorm) {
      emit(ThemeState(
        backgroundColor: Colors.deepPurple,
        textColor: Colors.white,
      ));
    } else {
      emit(ThemeState(
        backgroundColor: Colors.lightBlue,
        textColor: Colors.white,
      ));
    }
  }
}