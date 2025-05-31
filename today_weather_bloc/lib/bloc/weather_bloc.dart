import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_weather_bloc/models/weather_model.dart';
import 'package:today_weather_bloc/utils/location_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final LocationService _locationService = LocationService();
  final _apiKey = dotenv.env['WEATHER_KEY'] ?? '';

  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeatherData>(_onFetchWeatherData);
    on<RefreshWeatherData>(_onFetchWeatherData); // Same logic
  }

  Future<void> _onFetchWeatherData(
    WeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(WeatherLoading());

    bool locationAcquired = await _locationService.getCurrentLocation();

    if (!locationAcquired) {
      emit(WeatherError(_locationService.locationError ?? 'Location Error'));
      return;
    }

    try {
      final dio = Dio();
      final lat = _locationService.latitude ?? 13.7563;
      final lon = _locationService.longitude ?? 100.5018;

      final currentResponse = await dio.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_apiKey',
      );

      final forecastResponse = await dio.get(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$_apiKey',
      );

      final currentWeather = Weather.fromJson(currentResponse.data);
      final forecast = Weather.fromForecastJson(forecastResponse.data);

      emit(WeatherLoaded(currentWeather, forecast));
    } catch (e) {
      emit(WeatherError('Failed to fetch data: $e'));
    }
  }
}
