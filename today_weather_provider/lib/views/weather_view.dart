import 'package:flutter/material.dart';
import 'package:today_weather_provider/models/weather_model.dart';
import 'package:provider/provider.dart';
import 'package:today_weather_provider/viewModels/weather_view_model.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<WeatherViewModel>(context, listen: false).fetchAllData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherViewModel>(
      builder: (context, weatherViewModel, child) {
        return Scaffold(
          body:
              weatherViewModel.isLoading
                  ? _loadingComponent()
                  : _mainComponent(weatherViewModel),
        );
      },
    );
  }

  Widget _mainComponent(WeatherViewModel weatherViewModel) {
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
                    if (weatherViewModel.currentWeather != null)
                      _weather(
                        weather: weatherViewModel.currentWeather!,
                        textColor: Colors.white,
                      ),
                    IconButton(
                      onPressed: () {
                        weatherViewModel.fetchAllData();
                      },
                      icon: Icon(Icons.refresh, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: weatherViewModel.weathers.length,
                    itemBuilder: (context, index) {
                      final weather = weatherViewModel.weathers[index];
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
