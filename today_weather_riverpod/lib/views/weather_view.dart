import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_weather_riverpod/models/weather_model.dart';
import 'package:today_weather_riverpod/viewModels/weather_view_model.dart';

class WeatherView extends ConsumerWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherProvider);
    final weatherVM = ref.read(weatherProvider.notifier);

    return Scaffold(
      body:
          weatherState.isLoading
              ? _loadingComponent()
              : _mainComponent(weatherState, weatherVM),
    );
  }

  Widget _mainComponent(WeatherState state, WeatherViewModel vm) {
    return Container(
      color: Colors.blueGrey,
      child: Center(
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: [
                    if (state.currentWeather != null)
                      _weather(
                        weather: state.currentWeather!,
                        textColor: Colors.white,
                      ),
                    IconButton(
                      onPressed: () => vm.fetchAllData(),
                      icon: const Icon(Icons.refresh, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.weathers.length,
                    itemBuilder: (context, index) {
                      final weather = state.weathers[index];
                      return _weatherCard(weather: weather);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadingComponent() {
    return const Center(
      child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2),
    );
  }

  Widget _weatherCard({required Weather weather}) {
    return Card(
      child: _weather(
        weather: weather,
        textColor: const Color.fromARGB(255, 136, 116, 116),
      ),
    );
  }

  Widget _weather({required Weather weather, Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              weather.city,
              style: TextStyle(color: textColor ?? Colors.white),
            ),
            Text(
              weather.condition,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: textColor ?? Colors.white,
              ),
            ),
            Text(
              weather.temperature.toString(),
              style: TextStyle(color: textColor ?? Colors.white),
            ),
            Image.network(weather.iconUrl, width: 32, height: 32),
            Text(
              weather.formattedDate,
              style: TextStyle(color: textColor ?? Colors.white),
            ),
            Text(
              weather.formattedTime,
              style: TextStyle(color: textColor ?? Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
