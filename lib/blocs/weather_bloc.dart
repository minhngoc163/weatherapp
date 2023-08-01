import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/events/weather_event.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:weatherapp/repositories/weather_repository.dart';
import 'package:weatherapp/states/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository})
      : super(WeatherStateInitial()) {
    on<WeatherEventRequested>(_onWeatherEventRequested);
  }

  Future<void> _onWeatherEventRequested(
      WeatherEventRequested event, Emitter<WeatherState> emit) async {
    try {
      print('Fetching weather for city: ${event.city}');
      emit(WeatherStateLoading());
      final Weather weather =
      await weatherRepository.getWeatherFromCity(event.city);
      print('Weather data fetched successfully: $weather');
      emit(WeatherStateSuccess(weather: weather));
    } catch (exception) {
      print('Error fetching weather data: $exception');
      emit(WeatherStateFailure());
    }
  }

  Stream<WeatherState> mapEventToState(WeatherEvent weatherEvent) async* {
    if (weatherEvent is WeatherEventRefresh) {
      try {
        final Weather weather =
        await weatherRepository.getWeatherFromCity(weatherEvent.city);
        yield WeatherStateSuccess(weather: weather);
      } catch (exception) {
        yield WeatherStateFailure();
      }
    }
  }
}
