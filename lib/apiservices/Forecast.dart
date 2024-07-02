class Forecast {
  final String message;
  final ForecastData data;

  Forecast({
    required this.message,
    required this.data,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      message: json['message'],
      data: ForecastData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class ForecastData {
  final String maxTemp;
  final String minTemp;
  final String rainfall;
  final String relativeHumidity;
  final String windSpeed;
  final String windDirection;
  final String cloudCover;
  final String tempHumidityIndex;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  ForecastData({
    required this.maxTemp,
    required this.minTemp,
    required this.rainfall,
    required this.relativeHumidity,
    required this.windSpeed,
    required this.windDirection,
    required this.cloudCover,
    required this.tempHumidityIndex,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    return ForecastData(
      maxTemp: json['max_temp'] ?? '0',
      minTemp: json['min_temp'] ?? '0',
      rainfall: json['rainfall'] ?? '0',
      relativeHumidity: json['relative_humidity'] ?? '0',
      windSpeed: json['wind_speed'] ?? '0',
      windDirection: json['wind_direction'] ?? '0',
      cloudCover: json['cloud_cover'] ?? '0',
      tempHumidityIndex: json['temp_humidity_index'] ?? '0',
      updatedAt: DateTime.parse(json['updated_at']),
      createdAt: DateTime.parse(json['created_at']),
      id: json['id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'max_temp': maxTemp,
      'min_temp': minTemp,
      'rainfall': rainfall,
      'relative_humidity': relativeHumidity,
      'wind_speed': windSpeed,
      'wind_direction': windDirection,
      'cloud_cover': cloudCover,
      'temp_humidity_index': tempHumidityIndex,
      'updated_at': updatedAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'id': id,
    };
  }
}
