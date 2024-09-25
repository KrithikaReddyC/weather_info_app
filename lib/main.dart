import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(WeatherInfoApp());
}

class WeatherInfoApp extends StatefulWidget {
  @override
  _WeatherInfoAppState createState() => _WeatherInfoAppState();
}

class _WeatherInfoAppState extends State<WeatherInfoApp> {
  String city = '';
  String weather = '';
  double temperature = 0.0;

  void fetchWeatherData() {
    setState(() {
      temperature = Random().nextDouble() * (30 - 15) + 15; // Simulate temp
      List<String> conditions = ['Sunny', 'Cloudy', 'Rainy'];
      weather = conditions[Random().nextInt(conditions.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Info',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather Info'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Enter city name'),
                onChanged: (value) {
                  city = value;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  fetchWeatherData();
                },
                child: Text('Fetch Weather'),
              ),
              SizedBox(height: 20),
              Text('City: $city'),
              Text('Temperature: ${temperature.toStringAsFixed(2)}°C'),
              Text('Condition: $weather'),
            ],
          ),
        ),
      ),
    );
  }
}
