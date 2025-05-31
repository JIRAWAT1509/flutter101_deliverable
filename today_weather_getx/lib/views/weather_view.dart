import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:today_weather_getx/models/weather_model.dart';
import 'package:today_weather_getx/viewModels/weather_view_model.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherCtrl = Get.put(WeatherController());

    return Scaffold(
      body: Obx(() {
        if (weatherCtrl.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              strokeWidth: 2,
            ),
          );
        }

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
                        if (weatherCtrl.currentWeather.value != null)
                          _weather(
                            weather: weatherCtrl.currentWeather.value!,
                            textColor: Colors.white,
                          ),
                        IconButton(
                          onPressed: () => weatherCtrl.fetchAllData(),
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
                        itemCount: weatherCtrl.weathers.length,
                        itemBuilder: (context, index) {
                          final weather = weatherCtrl.weathers[index];
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
      }),
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
