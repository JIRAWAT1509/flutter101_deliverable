import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_weather_riverpod/models/weather_model.dart';
import 'package:today_weather_riverpod/utils/location_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// === State Model ===
class WeatherState {
  final bool isLoading;
  final Weather? currentWeather;
  final List<Weather> weathers;

  WeatherState({
    this.isLoading = false,
    this.currentWeather,
    this.weathers = const [],
  });

  WeatherState copyWith({
    bool? isLoading,
    Weather? currentWeather,
    List<Weather>? weathers,
  }) {
    return WeatherState(
      isLoading: isLoading ?? this.isLoading,
      currentWeather: currentWeather ?? this.currentWeather,
      weathers: weathers ?? this.weathers,
    );
  }
}

// === StateNotifier (ViewModel) ===
class WeatherViewModel extends StateNotifier<WeatherState> {
  final LocationService _locationService = LocationService();

  WeatherViewModel() : super(WeatherState());

  String get _apiKey => dotenv.env['WEATHER_KEY'] ?? '';

  Future<void> fetchAllData() async {
    state = state.copyWith(isLoading: true);

    bool locationAcquired = await _locationService.getCurrentLocation();

    if (!locationAcquired) {
      print('Failed to acquire location.');
      if (_locationService.locationError != null) {
        print('Location Error: ${_locationService.locationError}');
      }
    } else {
      print(
        'Location acquired: Lat: ${_locationService.latitude}, Lon: ${_locationService.longitude}',
      );
    }

    try {
      final currentWeather = await fetchWeatherData();
      final forecast = await fetchForecastData();

      state = state.copyWith(
        isLoading: false,
        currentWeather: currentWeather,
        weathers: forecast,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print('Error fetching data: $e');
    }
  }

  Future<Weather> fetchWeatherData() async {
    final dio = Dio();
    final lat = _locationService.latitude ?? 13.7563;
    final lon = _locationService.longitude ?? 100.5018;

    final response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_apiKey',
    );

    if (response.statusCode == 200) {
      final data = response.data;
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<Weather>> fetchForecastData() async {
    final dio = Dio();
    final lat = _locationService.latitude ?? 13.7563;
    final lon = _locationService.longitude ?? 100.5018;

    final response = await dio.get(
      'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$_apiKey',
    );

    if (response.statusCode == 200) {
      final data = response.data;
      return Weather.fromForecastJson(data);
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}

// === Provider (Global) ===
final weatherProvider = StateNotifierProvider<WeatherViewModel, WeatherState>(
  (ref) => WeatherViewModel(),
);
