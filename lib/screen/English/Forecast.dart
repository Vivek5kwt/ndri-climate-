import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Forecast extends StatefulWidget {
  @override
  _ForecastState createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  static const String apiKey = '3c16971b948395ea13a34a7880b2a9d0';
  static const String cityName = 'pune';

  Map<String, dynamic> ranges = {};
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<dynamic> fetchWeatherData() async {
    final String apiUrl = 'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&units=metric&appid=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final dailyData = processDailyData(data['list']);
        calculateRanges(dailyData);
        return dailyData;
      } else {
        setState(() {
          errorMessage = 'Failed to load weather data. Please check the city name or try again later.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred: $e';
        isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> processDailyData(List<dynamic> list) {
    Map<String, List<Map<String, dynamic>>> dailyData = {};

    for (var entry in list) {
      final date = DateTime.parse(entry['dt_txt']).toLocal();
      final dayKey = '${date.year}-${date.month}-${date.day}';

      if (!dailyData.containsKey(dayKey)) {
        dailyData[dayKey] = [];
      }

      double temp = _toDouble(entry['main']['temp']);
      double humidity = _toDouble(entry['main']['humidity']);

      dailyData[dayKey]!.add({
        'temp_min': _toDouble(entry['main']['temp_min']),
        'temp_max': _toDouble(entry['main']['temp_max']),
        'humidity': humidity,
        'clouds': _toDouble(entry['clouds']['all']),
        'rain': entry['rain'] != null ? _toDouble(entry['rain']['3h'] ?? 0.0) : 0.0,
        'wind_speed': _toDouble(entry['wind']['speed']),
        'wind_direction': _toDouble(entry['wind']['deg']),
        'rainfall': entry['rain'] != null ? _toDouble(entry['rain']['3h'] ?? 0.0) : 0.0,
        'THI': temp - ((0.55 - (0.55 * humidity / 100)) * (temp - 14.5)),
        'RH': humidity,
      });
    }

    return dailyData.values.take(7).map((dayEntries) {
      final tempMinValues = dayEntries.map((e) => e['temp_min']).toList();
      final tempMaxValues = dayEntries.map((e) => e['temp_max']).toList();
      final humidityValues = dayEntries.map((e) => e['humidity']).toList();
      final cloudCoverValues = dayEntries.map((e) => e['clouds']).toList();
      final precipitationValues = dayEntries.map((e) => e['rain']).toList();
      final windSpeedValues = dayEntries.map((e) => e['wind_speed']).toList();
      final windDirectionValues = dayEntries.map((e) => e['wind_direction']).toList();
      final rainfallValues = dayEntries.map((e) => e['rainfall']).toList();
      final THIValues = dayEntries.map((e) => e['THI']).toList();
      final RHValues = dayEntries.map((e) => e['RH']).toList();

      return {
        'temp_min': tempMinValues.reduce((a, b) => a < b ? a : b),
        'temp_max': tempMaxValues.reduce((a, b) => a > b ? a : b),
        'humidity': humidityValues.reduce((a, b) => a < b ? a : b),
        'clouds': cloudCoverValues.reduce((a, b) => a < b ? a : b),
        'rain': precipitationValues.reduce((a, b) => a < b ? a : b),
        'wind_speed': windSpeedValues.reduce((a, b) => a + b),
        'wind_direction': windDirectionValues.reduce((a, b) => a + b) / windDirectionValues.length,
        'rainfall': rainfallValues.reduce((a, b) => a + b),
        'THI': THIValues.reduce((a, b) => a + b) / THIValues.length,
        'RH': RHValues.reduce((a, b) => a < b ? a : b),
      };
    }).toList();
  }

  double _toDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return 0.0;
    }
  }

  void calculateRanges(List<Map<String, dynamic>> dailyData) {
    final tempMinValues = dailyData.map((day) => day['temp_min']).toList();
    final tempMaxValues = dailyData.map((day) => day['temp_max']).toList();
    final humidityValues = dailyData.map((day) => day['humidity']).toList();
    final cloudCoverValues = dailyData.map((day) => day['clouds']).toList();
    final precipitationValues = dailyData.map((day) => day['rain']).toList();
    final windSpeedValues = dailyData.map((day) => day['wind_speed']).toList();
    final windDirectionValues = dailyData.map((day) => day['wind_direction']).toList();
    final rainfallValues = dailyData.map((day) => day['rainfall']).toList();
    final THIValues = dailyData.map((day) => day['THI']).toList();
    final RHValues = dailyData.map((day) => day['RH']).toList();

    setState(() {
      ranges = {
        'Temperature Min (°C)': [
          tempMinValues.reduce((a, b) => a < b ? a : b),
          tempMinValues.reduce((a, b) => a > b ? a : b)
        ],
        'Temperature Max (°C)': [
          tempMaxValues.reduce((a, b) => a < b ? a : b),
          tempMaxValues.reduce((a, b) => a > b ? a : b)
        ],
        'Humidity (%)': [
          humidityValues.reduce((a, b) => a < b ? a : b),
          humidityValues.reduce((a, b) => a > b ? a : b)
        ],
        'Cloud Cover (%)': [
          cloudCoverValues.reduce((a, b) => a < b ? a : b),
          cloudCoverValues.reduce((a, b) => a > b ? a : b)
        ],
        'Precipitation (mm)': [
          precipitationValues.reduce((a, b) => a < b ? a : b),
          precipitationValues.reduce((a, b) => a > b ? a : b)
        ],
        'Wind Speed (m/s)': [
          windSpeedValues.reduce((a, b) => a < b ? a : b),
          windSpeedValues.reduce((a, b) => a > b ? a : b)
        ],
        'Wind Direction (°)': [
          windDirectionValues.reduce((a, b) => a < b ? a : b),
          windDirectionValues.reduce((a, b) => a > b ? a : b)
        ],
        'Rainfall (mm)': [
          rainfallValues.reduce((a, b) => a < b ? a : b),
          rainfallValues.reduce((a, b) => a > b ? a : b)
        ],
        'THI': [
          THIValues.reduce((a, b) => a < b ? a : b),
          THIValues.reduce((a, b) => a > b ? a : b)
        ],
        'RH (%)': [
          RHValues.reduce((a, b) => a < b ? a : b),
          RHValues.reduce((a, b) => a > b ? a : b)
        ],
      };
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double fontSize = width * 0.045;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '7-Day Weather Forecast for $cityName',
          style: TextStyle(fontSize: fontSize + 2),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.08),
          child: Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: fontSize),
          ),
        ),
      )
          : Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: width * 0.02,
        ),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: ranges.length,
            separatorBuilder: (_, __) => Divider(height: 1),
            itemBuilder: (context, idx) {
              String key = ranges.keys.elementAt(idx);
              var val = ranges[key];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: width * 0.06, vertical: width * 0.03),
                title: Text(
                  key,
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  '${val[0].toStringAsFixed(1)}  -  ${val[1].toStringAsFixed(1)}',
                  style: TextStyle(
                      fontSize: fontSize * 0.92,
                      fontWeight: FontWeight.w400,
                      color: Colors.blueGrey[700]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
