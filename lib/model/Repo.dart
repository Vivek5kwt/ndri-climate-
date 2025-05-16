import 'dart:convert';

import'package:http/http.dart' as http;
import 'package:ndri_climate/main.dart';
import 'package:ndri_climate/model/Weather_Forecast.dart';
// import 'package:ndri_climate/model/Weather_Forecast.dart';
// import 'package:ndri_climate/model/Weather_model.dart';
class Repo{
  getweather( String? district) async{
    var url=
    "https://api.openweathermap.org/data/2.5/forecast?q=$district&cnt=7&appid=$api_key";
    print('dsdjsdjsjh ${url}');

    final res= await http.get(Uri.parse(url));
    final resBody=res.body;
    if (res.statusCode==200) {
      return WeatherResponse.fromJson(json.decode(resBody));
    }
    throw Exception();
  } 
  Future<dynamic> fetchWeatherData({required String district}) async {
    final String apiUrl = 'https://api.openweathermap.org/data/2.5/forecast?q=$district&units=metric&appid=$api_key';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final list = data['list'];
        final dailyData = processDailyData(list);
        // final dailyData = getrangedata(data['list']);
        return dailyData;
        
      } else {
          print('Exception : "${response.body}"');
        }
      }
     catch (e) {
     print('Error : $e');
    }
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
        'wind_speed': _toDouble(entry['wind']['speed']),
        'clouds': _toDouble(entry['clouds']['all']/12.5),
        'rain': entry['rain'] != null ? _toDouble(entry['rain']['3h'] ?? 0.0) : 0.0,
        'wind_direction': _toDouble(entry['wind']['deg']),
        'rainfall': entry['rain'] != null ? _toDouble(entry['rain']['3h'] ?? 0.0) : 0.0,
        'THI': temp - ((0.55 - (0.55 * humidity / 100)) * (temp - 14.5)),  // Calculating THI
        'RH': humidity,
      });
    }

    return dailyData.values.take(7).map((dayEntries) {
      final tempMinValues = dayEntries.map((e) => e['temp_min']).toList();
      final tempMaxValues = dayEntries.map((e) => e['temp_max']).toList();
      final humidityValues = dayEntries.map((e) => e['humidity']).toList();
      final cloudCoverValues = dayEntries.map((e) => e['clouds']).toList();
      final precipitationValues = dayEntries.map((e) => e['rain']).toList();
      final windDirectionValues = dayEntries.map((e) => e['wind_direction']).toList();
      final rainfallValues = dayEntries.map((e) => e['rainfall']).toList();
      final THIValues = dayEntries.map((e) => e['THI']).toList();
      final windSpeedValues = dayEntries.map((e) => e['wind_speed']).toList();
      final RHValues = dayEntries.map((e) => e['RH']).toList();

      return {
        'temp_min': tempMinValues.reduce((a, b) => a < b ? a : b),
        'temp_max': tempMaxValues.reduce((a, b) => a > b ? a : b),
        'humidity': humidityValues.reduce((a, b) => a < b ? a : b),
        'clouds': cloudCoverValues.reduce((a, b) => a < b ? a : b),
        'rain': precipitationValues.reduce((a, b) => a < b ? a : b),
        'wind_speed': windSpeedValues.reduce((a, b) => a + b),
        'wind_direction': windDirectionValues.reduce((a, b) => a + b) / windDirectionValues.length, // Average wind direction
        'rainfall': rainfallValues.reduce((a, b) => a + b), // Total rainfall
        'THI': THIValues.reduce((a, b) => a + b) / THIValues.length, // Average THI
        'RH': RHValues.reduce((a, b) => a < b ? a : b), // Minimum RH
      };
    }).toList();
  }
 



}