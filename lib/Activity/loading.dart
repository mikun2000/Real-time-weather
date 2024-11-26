import 'package:flutter/material.dart';
import 'package:realtime_weather_app/Worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late String city = "Bhubaneswar";
  late String temp;
  late String humidity;
  late String airSpeed;
  late String description;
  late String main;
  late String icon;

  void startApp(String city) async {
    Worker instance = Worker(location: city);

    await instance.getData();
    if (!mounted) return;

    airSpeed = instance.airSpeed;
    temp = instance.temp;
    humidity = instance.humidity;
    description = instance.description;
    main = instance.main;
    icon = instance.icon;

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'tempValue': temp,
        'airSpeedValue': airSpeed,
        'humidityValue': humidity,
        'descriptionValue': description,
        'iconValue': icon,
        'cityValue': city,
        'mainValue': main
      });
    });

    //print('Temp: $temp');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map? search = ModalRoute.of(context)!.settings.arguments as Map?;
    //city = search!['searchText'];
    if (search?.isNotEmpty ?? false) {
      city = search?['searchText'];
    }
    startApp(city);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center the column
            children: <Widget>[
              SizedBox(
                height: 180,
              ),
              Image.asset(
                "assets/images/weatherimg.jpg",
                height: 240,
                width: 240,
              ),
              const Text(
                "Real Time Weather App",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 73, 82, 219)),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Made by Soumya",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 73, 82, 219)),
              ),
              const SizedBox(
                height: 30,
              ),
              const SpinKitWave(
                color: Color.fromARGB(255, 189, 48, 170),
                size: 50.00,
              ), // Properly closed SpinKitChasingDots
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 15, 214, 181),
    );
  }
}
