import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ndri_climate/apiservices/advisory.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  final String headUrl = "https://ndrics.in";

  /// Store weather data
  Future<dynamic> storeWeatherData({
    required String district,
    required int maxTempHigh,
    required int maxTempLow,
    required int minTempHigh,
    required int minTempLow,
    required int rainfallHigh,
    required int rainfallLow,
    required int relativeHumidityHigh,
    required int relativeHumidityLow,
    required int windSpeedHigh,
    required int windSpeedLow,
    required int windDirectionHigh,
    required int windDirectionLow,
    required int cloudCoverHigh,
    required int cloudCoverLow,
    required int tempHumidityIndexHigh,
    required int tempHumidityIndexLow,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final url = Uri.parse('\$headUrl/api/forecasts');
    final headers = {'Content-Type': 'application/json', 'Accept': 'application/json'};
    final body = jsonEncode({
      'district': district,
      'max_temp_high': maxTempHigh,
      'max_temp_low': maxTempLow,
      'min_temp_high': minTempHigh,
      'min_temp_low': minTempLow,
      'rainfall_high': rainfallHigh,
      'rainfall_low': rainfallLow,
      'relative_humidity_high': relativeHumidityHigh,
      'relative_humidity_low': relativeHumidityLow,
      'wind_speed_high': windSpeedHigh,
      'wind_speed_low': windSpeedLow,
      'wind_direction_high': windDirectionHigh,
      'wind_direction_low': windDirectionLow,
      'cloud_cover_high': cloudCoverHigh,
      'cloud_cover_low': cloudCoverLow,
      'temp_humidity_index_high': tempHumidityIndexHigh,
      'temp_humidity_index_low': tempHumidityIndexLow,
    });
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        final id = data['data']['id']?.toString() ?? '';
        prefs.setString('forecast_id', id);
        return data;
      } else {
        print('Error: \${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception: \$e');
      return null;
    }
  }

  /// Get weather data by ID
  Future<dynamic> getWeatherData({required String id}) async {
    final url = Uri.parse('\$headUrl/api/forecasts/\$id');
    final headers = {'Content-Type': 'application/json', 'Accept': 'application/json'};
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error: \${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception: \$e');
      return null;
    }
  }

  /// Store user feedback
  Future<dynamic> storeFeedback({
    required String phoneNumber,
    required String customerName,
    required String district,
    required String message,
  }) async {
    final url = Uri.parse('\$headUrl/api/feedback');
    final headers = {'Content-Type': 'application/json', 'Accept': 'application/json'};
    final body = jsonEncode({
      'phone_number': phoneNumber,
      'customer_name': customerName,
      'district': district,
      'message': message,
    });
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        print('Error: \${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception: \$e');
      return null;
    }
  }

  Future<List<Advisory>> fetchAdvisory({
    required String state,
    required String district,
  }) async {
    final encS = Uri.encodeComponent(state);
    final encD = Uri.encodeComponent(district);
    final url = Uri.parse('$headUrl/api/advisories/$encS/$encD');
    print('dskdksdj $url');
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final list = json.decode(resp.body) as List;
      return list.map((e) => Advisory.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getStates() async {
    final url = Uri.parse('https://cdn-api.co-vin.in/api/v2/admin/location/states');
    final resp = await http.get(url, headers: {'Accept': 'application/json'});
    if (resp.statusCode == 200) {
      return (json.decode(resp.body)['states'] as List);
    }
    return [];
  }

  Future<List<String>> getDistrictsByStateId(String id) async {
    final url = Uri.parse('https://cdn-api.co-vin.in/api/v2/admin/location/districts/$id');
    final resp = await http.get(url, headers: {'Accept': 'application/json'});
    if (resp.statusCode == 200) {
      return (json.decode(resp.body)['districts'] as List)
          .map((e) => e['district_name'] as String)
          .toList();
    }
    return [];
  }
}
