import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:today_weather_bloc/bloc/weather_event.dart';
import 'package:today_weather_bloc/views/weather_view.dart';
import 'package:today_weather_bloc/bloc/weather_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherBloc()..add(FetchWeatherData()),
      child: MaterialApp(
        title: 'Today Weather App',
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        home: const WeatherView(),
      ),
    );
  }
}
