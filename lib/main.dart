import 'package:flutter/material.dart';
import 'package:realtime_weather_app/Activity/home.dart';
import 'package:realtime_weather_app/Activity/loading.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      "/": (context) => const Loading(),
      "/home": (context) => const Home(),
      "/loading": (context) => const Loading(),
    },
  ));
}
