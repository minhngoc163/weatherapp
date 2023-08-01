import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weatherapp/blocs/settings_bloc.dart';
import 'package:weatherapp/blocs/theme_bloc.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/states/settings_state.dart';
import 'package:weatherapp/states/theme_state.dart';

class TemperatureWidget extends StatelessWidget {
  final Weather weather;

  TemperatureWidget({required Key key, required this.weather}) : super(key: key);

  String _formattedTemperature(double temp, TemperatureUnit temperatureUnit) {
    if (temperatureUnit == TemperatureUnit.celsius) {
      return '${(temp - 273.15).round()}°C';
    } else {
      double fahrenheit = ((temp - 273.15) * 9 / 5) + 32;
      return '${fahrenheit.round()}°F';
    }
  }

  // Get the correct temperature unit from the settings state
  TemperatureUnit _getTemperatureUnit(BuildContext context) {
    return BlocProvider.of<SettingsBloc>(context).state.temperatureUnit;
  }

  BoxedIcon _mapWeatherConditionToIcon({required WeatherCondition weatherCondition}) {
    switch (weatherCondition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        return BoxedIcon(WeatherIcons.day_sunny);
      case WeatherCondition.hail:
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        return BoxedIcon(WeatherIcons.snow);
      case WeatherCondition.heavyCloud:
        return BoxedIcon(WeatherIcons.cloud_up);
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        return BoxedIcon(WeatherIcons.rain);
      case WeatherCondition.thunderstorm:
        return BoxedIcon(WeatherIcons.thunderstorm);
      case WeatherCondition.unknown:


      // Remaining code remains unchanged
      // ...
    }
    return BoxedIcon(WeatherIcons.sunset);
  }

  @override
  Widget build(BuildContext context) {
    ThemeState _themeState = BlocProvider.of<ThemeBloc>(context).state;
    TemperatureUnit _temperatureUnit = _getTemperatureUnit(context);

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _mapWeatherConditionToIcon(weatherCondition: weather.weatherCondition),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Min temp: ${_formattedTemperature(weather.minTemp, _temperatureUnit)}',
                    style: TextStyle(
                      fontSize: 18,
                      color: _themeState.textColor,
                    ),
                  ),
                  Text(
                    'Temp: ${_formattedTemperature(weather.temp, _temperatureUnit)}',
                    style: TextStyle(
                      fontSize: 18,
                      color: _themeState.textColor,
                    ),
                  ),
                  Text(
                    'Max temp: ${_formattedTemperature(weather.maxTemp, _temperatureUnit)}',
                    style: TextStyle(
                      fontSize: 18,
                      color: _themeState.textColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
