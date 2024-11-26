import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    print("This is a init state");
  }

  @override
  void setState(fn) {
    super.setState(fn);
    print("Set state called");
  }

  @override
  void dispose() {
    super.dispose();
    print("Widget Destroyed");
  }

  @override
  Widget build(BuildContext context) {
    var city_name = [
      "Bhubaneswar",
      "Hyderabad",
      "Bangalore",
      "London",
      "Mumbai"
    ];

    var city_index = Random().nextInt(city_name.length);
    Map? info = ModalRoute.of(context)?.settings.arguments as Map;
    String temp = (info['tempValue']?.toString() ?? 'NA');
    String airSpeed = (info['airSpeedValue']?.toString() ?? '0');

    if (temp != "NA") {
      temp = temp.length >= 4 ? temp.substring(0, 4) : temp;
      airSpeed = airSpeed.length >= 4 ? airSpeed.substring(0, 4) : airSpeed;
    }

    String icon = info['iconValue'];
    String getcity = info['cityValue'] ?? 'Unknown City';
    String humidity = info['humidityValue']?.toString() ?? '0';
    String description = info['descriptionValue'] ?? 'No description';
    print('iconValue =$icon');
    return Scaffold(
      // resizeToAvoidBottomInset: bool.fromEnvironment(false as String),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Colors.green,
          )),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blue[800]!, Colors.blue[300]!])),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  margin: const EdgeInsetsDirectional.symmetric(
                      horizontal: 14, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if ((searchController.text).replaceAll(" ", "") ==
                              "") {
                            print("Blank search");
                          } else {
                            Navigator.pushReplacementNamed(context, "/loading",
                                arguments: {
                                  "searchText": searchController.text,
                                });
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                          child: const Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      Expanded(
                          child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Any City Name"),
                      ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Image.network(
                                "https://openweathermap.org/img/wn/$icon@2x.png",
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.error);
                                },
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "$description",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "In $getcity",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white.withOpacity(0.5),
                        ),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        padding: const EdgeInsets.all(26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(WeatherIcons.thermometer),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "$temp",
                                  style: TextStyle(fontSize: 70),
                                ),
                                const Text(
                                  "C",
                                  style: TextStyle(fontSize: 30),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          margin: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                          padding: const EdgeInsets.all(26),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [Icon(WeatherIcons.day_windy)],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "$airSpeed",
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              Text("km/hr")
                            ],
                          )),
                    ),
                    Expanded(
                      child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white.withOpacity(0.5),
                          ),
                          margin: const EdgeInsets.fromLTRB(10, 0, 20, 0),
                          padding: const EdgeInsets.all(26),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [Icon(WeatherIcons.humidity)],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                "$humidity",
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              Text("percent")
                            ],
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 120),
                Container(
                  padding: const EdgeInsets.all(30),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Made By Soumya"),
                      Text("Data Provided By Openweather.org")
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
