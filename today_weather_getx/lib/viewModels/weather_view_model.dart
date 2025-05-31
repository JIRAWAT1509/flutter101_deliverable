import 'package:get/get.dart';
import 'package:today_weather_getx/models/weather_model.dart';
import 'package:today_weather_getx/utils/location_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherController extends GetxController {
  final LocationService _locationService = LocationService();
  final isLoading = false.obs;
  final currentWeather = Rxn<Weather>();
  final weathers = <Weather>[].obs;

  String get _apiKey => dotenv.env['WEATHER_KEY'] ?? '';

  @override
  void onInit() {
    super.onInit();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    isLoading.value = true;

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
      await Future.wait([fetchWeatherData(), fetchForecastData()]);
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchWeatherData() async {
    final dio = Dio();
    final lat = _locationService.latitude ?? 13.7563;
    final lon = _locationService.longitude ?? 100.5018;

    final response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_apiKey',
    );

    if (response.statusCode == 200) {
      currentWeather.value = Weather.fromJson(response.data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<void> fetchForecastData() async {
    final dio = Dio();
    final lat = _locationService.latitude ?? 13.7563;
    final lon = _locationService.longitude ?? 100.5018;

    final response = await dio.get(
      'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$_apiKey',
    );

    if (response.statusCode == 200) {
      weathers.assignAll(Weather.fromForecastJson(response.data));
    } else {
      throw Exception('Failed to load forecast data');
    }
  }
}
