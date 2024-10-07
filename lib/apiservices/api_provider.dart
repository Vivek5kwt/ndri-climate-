import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ndri_climate/apiservices/advisory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  final String headUrl = "https://ndri.ampleteckdev.com";

  Future<dynamic> storeWeatherData({
    required String District,
    required int max_temp_high,
    required int max_temp_low,
    required int min_temp_high,
    required int min_temp_low,
    required int rainfall_high,
    required int rainfall_low,
    required int relative_humidity_high,
    required int relative_humidity_low,
    required int wind_speed_high,
    required int wind_speed_low,
    required int wind_direction_high,
    required int wind_direction_low,
    required int cloud_cover_high,
    required int cloud_cover_low,
    required int temp_humidity_index_high,
    required int temp_humidity_index_low,
  }) async {
    SharedPreferences _prefs =await SharedPreferences.getInstance();
    final url = Uri.parse('$headUrl/api/forecasts');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final body = jsonEncode({
     "district": District,
      "max_temp_high":max_temp_high.toString() ,
      "max_temp_low": max_temp_low.toString(),
      "min_temp_high": min_temp_high.toString(),
      "min_temp_low": min_temp_low.toString(),
      "rainfall_high": rainfall_high.toString(),
      "rainfall_low": rainfall_low.toString(),
      "relative_humidity_high": relative_humidity_high.toString(),
      "relative_humidity_low": relative_humidity_low.toString(),
      "wind_speed_high": wind_speed_high.toString(),
      "wind_speed_low": wind_speed_low.toString(),
      "wind_direction_high": wind_direction_high.toString(),
      "wind_direction_low": wind_direction_low.toString(),
      "cloud_cover_high": cloud_cover_high.toString(),
      "cloud_cover_low": cloud_cover_low.toString(),
      "temp_humidity_index_high": temp_humidity_index_high.toString(),
      "temp_humidity_index_low": temp_humidity_index_low.toString(),
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

  Future<dynamic> storeFeedback({
    required String phone_number,
    required String customer_name,
    required String district,
    required String message,
  }) async {
    final url = Uri.parse('$headUrl/api/feedback');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final body = jsonEncode({
      "phone_number": phone_number,
      "customer_name": customer_name,
      "district": district,
      "message": message,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
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

  Future <List<Advisory>> fetchAdvisory() async {
  final response = await http.get(Uri.parse('$headUrl/api/advisories'));

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((json) => Advisory.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load events');
  }
}
}
