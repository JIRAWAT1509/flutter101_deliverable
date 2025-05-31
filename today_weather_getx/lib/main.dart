import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:today_weather_getx/views/weather_view.dart';
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
    return GetMaterialApp(
      // ใช้ GetMaterialApp แทน MaterialApp
      title: 'Today Weather App',
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const WeatherView(),
    );
  }
}
