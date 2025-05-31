import 'package:today_weather_bloc/models/weather_model.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather currentWeather;
  final List<Weather> forecast;

  WeatherLoaded(this.currentWeather, this.forecast);
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}
