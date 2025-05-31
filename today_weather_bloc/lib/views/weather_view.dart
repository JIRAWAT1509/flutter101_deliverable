import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_weather_bloc/bloc/weather_bloc.dart';
import 'package:today_weather_bloc/bloc/weather_event.dart';
import 'package:today_weather_bloc/bloc/weather_state.dart';
import 'package:today_weather_bloc/models/weather_model.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            return _mainComponent(context, state);
          } else if (state is WeatherError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Press refresh to load data'));
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => context.read<WeatherBloc>().add(RefreshWeatherData()),
      //   child: const Icon(Icons.refresh),
      // ),
    );
  }

  Widget _mainComponent(BuildContext context, WeatherLoaded state) {
    return Container(
      color: Colors.blueGrey,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  _weather(
                    weather: state.currentWeather,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ),
            SafeArea(
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.forecast.length,
                  itemBuilder: (context, index) {
                    final weather = state.forecast[index];
                    return _weatherCard(weather: weather);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
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
