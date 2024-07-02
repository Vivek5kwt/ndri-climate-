import 'dart:convert';

import'package:http/http.dart' as http;
import 'package:ndri_climate/model/Weather_Forecast.dart';
// import 'package:ndri_climate/model/Weather_Forecast.dart';
// import 'package:ndri_climate/model/Weather_model.dart';
class Repo{
  getweather( String? district) async{
    var url=
    "https://api.openweathermap.org/data/2.5/forecast?q=$district&cnt=7&appid=3c16971b948395ea13a34a7880b2a9d0";

    final res= await http.get(Uri.parse(url));
    final resBody=res.body;
    if (res.statusCode==200) {
      return WeatherResponse.fromJson(json.decode(resBody));
    }
    throw Exception();
  }

}