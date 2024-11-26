import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Worker {
  String location;

  // Constructor
  Worker({required this.location});

  String temp = '';
  String humidity = '';
  String airSpeed = '';
  String description = '';
  String main = '';
  String icon = '';

  // Method to fetch weather data
  Future<void> getData() async {
    try {
      // Make the API call
      final response = await get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=51c0f6af942f6e32534e6d3f26b2cedb",
        ),
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        print('data:$data');
        // Getting temperature and humidity
        Map tempData = data['main'];
        humidity = tempData['humidity'].toString(); //%
        double getTemp = tempData['temp'] - 273.15; //c
        temp = getTemp.toString();

        // Getting wind speed
        Map wind = data['wind'];
        airSpeed = wind['speed'].toString(); //km/h

        // Getting weather description
        List weatherData = data['weather'];
        print('weatherData:$weatherData');
        if (weatherData.isNotEmpty) {
          Map weatherMainData = weatherData[0];
          main = weatherMainData['main'];
          description = weatherMainData['description'];
          icon = weatherMainData['icon'].toString();
          //
        }
      } else {
        // Handle the case where the API call was unsuccessful
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
      print(icon);
    } catch (e) {
      // Assign error messages to variables
      temp = "NA";
      humidity = "NA";
      airSpeed = "NA";
      icon = "NA";
      description = "Can't Find Data!";
      main = "NA";
      icon = "09d";
      print('Error: $e'); // Log the error for debugging
    }
  }
}
