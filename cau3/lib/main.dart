import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  String apiKey = "644c8f4db2c9b952f122fdb27a9e0baa";
  String city = "";

  Future<Map<String, dynamic>> getWeatherData(String city) async {
    String apiUrl =
        "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";
    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _onSubmit() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Nhập địa điểm'),
              onChanged: (value) => city = value,
              onFieldSubmitted: (_) => _onSubmit(),
            ),
            SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: getWeatherData(city),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    var weatherData = snapshot.data;
                    var temperature = weatherData?['main']?['temp'];
                    var humidity = weatherData?['main']?['humidity'];
                    var description = weatherData?['weather']?[0]?['description'];

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Thành phố: $city'),
                          Text('Nhiệt độ: ${temperature ?? 'N/A'}°C'),
                          Text('Độ ẩm: ${humidity ?? 'N/A'}%'),
                          Text('Tình trạng thời tiết: ${description ?? 'N/A'}'),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
