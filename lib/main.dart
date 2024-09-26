import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: Colors.blueAccent,
        ),
        useMaterial3: true,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();

  String _cityName = '';
  String _temperature = 'Temperature: --';
  String _weatherCondition = 'Condition: --';
  List<String> _forecast = [];

  void _fetchWeather() {
    final city = _cityController.text;
    final random = Random();
    final temperature = random.nextInt(16) + 15; // 15 to 30
    final conditions = ['Sunny', 'Cloudy', 'Rainy'];
    final weatherCondition = conditions[random.nextInt(conditions.length)];

    setState(() {
      _cityName = city;
      _temperature = 'Temperature: ${temperature}°C';
      _weatherCondition = 'Condition: $weatherCondition';
    });
  }

  void _fetchForecast() {
    final random = Random();
    if (_temperature == 'Temperature: --') {
      // Ensure weather is fetched before fetching forecast
      return;
    }
    final currentTemperature = int.parse(_temperature.split(': ')[1].replaceAll('°C', ''));
    final currentCondition = _weatherCondition.split(': ')[1];

    List<String> forecast = [];
    forecast.add('Day 1: ${currentTemperature}°C, $currentCondition'); // Match Day 1 with current weather
    for (int i = 1; i < 7; i++) {
      final forecastTemperature = random.nextInt(16) + 15; // Random temp for other days
      final conditions = ['Sunny', 'Cloudy', 'Rainy'];
      final forecastCondition = conditions[random.nextInt(conditions.length)];
      forecast.add('Day ${i + 1}: ${forecastTemperature}°C, $forecastCondition');
    }

    setState(() {
      _forecast = forecast;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://media.istockphoto.com/id/1055026520/photo/clouds-background.jpg?s=612x612&w=0&k=20&c=T0cBt_8pBAPSQfMm4-wI5bGQynWwnLrVTauCyMS5dk4='),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'Enter City Name',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.yellow.withOpacity(0.8), // Slightly transparent background
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _fetchWeather,
                child: Text('Fetch Current Weather'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: _fetchForecast,
                child: Text('Fetch 7-Day Forecast'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Colors.white,
                ),
              ),
              SizedBox(height: 32.0),
              Text(
                'City: $_cityName',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                _temperature,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Text(
                _weatherCondition,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(height: 32.0),
              Text(
                '7-Day Forecast:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              ..._forecast.map((dayForecast) => Text(
                dayForecast,
                style: TextStyle(fontSize: 16, color: Colors.white),
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }
}