import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  final String headUrl = "https://ndri.ampleteckdev.com";

  Future<dynamic> storeWeatherData({
    required double max_temp,
    required double min_temp,
    required double rainfall,
    required double relative_humidity,
    required double wind_speed,
    required double wind_direction,
    required double cloud_cover,
    required double temp_humidity_index,
  }) async {
    SharedPreferences _prefs =await SharedPreferences.getInstance();
    final url = Uri.parse('$headUrl/api/forecasts');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final body = jsonEncode({
      "max_temp": max_temp.toString(),
      "min_temp": min_temp.toString(),
      "rainfall": rainfall.toString(),
      "relative_humidity": relative_humidity.toString(),
      "wind_speed": wind_speed.toString(),
      "wind_direction": wind_direction.toString(),
      "cloud_cover": cloud_cover.toString(),
      "temp_humidity_index": temp_humidity_index.toString()
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        int id = jsonData['data']['id'] ?? '';
        _prefs.setString('forecast_id',id.toString());
        print(jsonData);
        return jsonData;
      } else {
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null;
    }
  }

  
  Future<dynamic> getWeatherData({
   
    required String id,
  }) async {
    final url = Uri.parse('$headUrl/api/forecasts/$id');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
       
        return jsonData;
      } else {
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null;
    }
  }

//   Future<dynamic> storeAdvisoryData({
//     required String advisory_desc,
//     required String Date,
//   }) async {
//     final url = Uri.parse('$headUrl/api/advisories');
//     Map<String, String> headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     };

//     final body = jsonEncode({
//       "title": "Weather Advisory",
//       "description": advisory_desc,
//       "date": Date,
//     });

//     try {
//       final response = await http.post(url, headers: headers, body: body);
//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         final jsonData = json.decode(response.body);
//         return jsonData;
//       } else {
//         print('Error: ${response.statusCode} - ${response.reasonPhrase}');
//         return null;
//       }
//     } catch (e) {
//       print('Exception occurred: $e');
//       return null;
//     }
//   }
}
