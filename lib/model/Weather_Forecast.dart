class WeatherResponse {
  String cod;
  int message;
  int cnt;
  List<WeatherForecast> list;
  City city;

  WeatherResponse({
    required this.cod,
    required this.message,
    required this.cnt,
    required this.list,
    required this.city,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      cod: json['cod'],
      message: json['message'],
      cnt: json['cnt'],
      list: List<WeatherForecast>.from(
          json['list'].map((x) => WeatherForecast.fromJson(x))),
      city: City.fromJson(json['city']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cod': cod,
      'message': message,
      'cnt': cnt,
      'list': List<dynamic>.from(list.map((x) => x.toJson())),
      'city': city.toJson(),
    };
  }
}

class WeatherForecast {
  int dt;
  Main main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  int visibility;
  double pop;
  Rain? rain;
  Sys sys;
  String dtTxt;

  WeatherForecast({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    this.rain,
    required this.sys,
    required this.dtTxt,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      dt: json['dt'],
      main: Main.fromJson(json['main']),
      weather:
          List<Weather>.from(json['weather'].map((x) => Weather.fromJson(x))),
      clouds: Clouds.fromJson(json['clouds']),
      wind: Wind.fromJson(json['wind']),
      visibility: json['visibility'],
      pop: json['pop'].toDouble(),
      rain: json['rain'] != null ? Rain.fromJson(json['rain']) : null,
      sys: Sys.fromJson(json['sys']),
      dtTxt: json['dt_txt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dt,
      'main': main.toJson(),
      'weather': List<dynamic>.from(weather.map((x) => x.toJson())),
      'clouds': clouds.toJson(),
      'wind': wind.toJson(),
      'visibility': visibility,
      'pop': pop,
      'rain': rain?.toJson(),
      'sys': sys.toJson(),
      'dt_txt': dtTxt,
    };
  }
}

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int seaLevel;
  int grndLevel;
  int humidity;
  double tempKf;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.seaLevel,
    required this.grndLevel,
    required this.humidity,
    required this.tempKf,
  });

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
      temp: json['temp'].toDouble(),
      feelsLike: json['feels_like'].toDouble(),
      tempMin: json['temp_min'].toDouble(),
      tempMax: json['temp_max'].toDouble(),
      pressure: json['pressure'],
      seaLevel: json['sea_level'],
      grndLevel: json['grnd_level'],
      humidity: json['humidity'],
      tempKf: json['temp_kf'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'sea_level': seaLevel,
      'grnd_level': grndLevel,
      'humidity': humidity,
      'temp_kf': tempKf,
    };
  }
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json['id'],
      main: json['main'],
      description: json['description'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }
}

class Clouds {
  int all;

  Clouds({
    required this.all,
  });

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all: json['all'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'all': all,
    };
  }
}

class Wind {
  double speed;
  int deg;
  double gust;

  Wind({
    required this.speed,
    required this.deg,
    required this.gust,
  });

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed: json['speed'].toDouble(),
      deg: json['deg'],
      gust: json['gust'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
      'deg': deg,
      'gust': gust,
    };
  }
}

class Rain {
  double h3;

  Rain({
    required this.h3,
  });

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(
      h3: json['3h'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '3h': h3,
    };
  }
}

class Sys {
  String pod;

  Sys({
    required this.pod,
  });

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      pod: json['pod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pod': pod,
    };
  }
}

class City {
  int id;
  String name;
  Coord coord;
  String country;
  int population;
  int timezone;
  int sunrise;
  int sunset;

  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      coord: Coord.fromJson(json['coord']),
      country: json['country'],
      population: json['population'],
      timezone: json['timezone'],
      sunrise: json['sunrise'],
      sunset: json['sunset'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'coord': coord.toJson(),
      'country': country,
      'population': population,
      'timezone': timezone,
      'sunrise': sunrise,
      'sunset': sunset,
    };
  }
}

class Coord {
  double lat;
  double lon;

  Coord({
    required this.lat,
    required this.lon,
  });

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lon': lon,
    };
  }
}

class WeatherMetrics {
  Map<String, dynamic> ranges = {};
    Map<String, List<Map<String, dynamic>>> dailyData = {};


   processDailyData(List<dynamic> list) {
    // Reset ranges
    // ranges.clear();

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
        'wind_speed': _toDouble(entry['wind']['speed']),
        'rain': entry['rain'] != null ? _toDouble(entry['rain']['3h'] ?? 0.0) : 0.0,
        'wind_speed': _toDouble(entry['wind']['speed']),
        'wind_direction': _toDouble(entry['wind']['deg']),
        'rainfall': entry['rain'] != null ? _toDouble(entry['rain']['3h'] ?? 0.0) : 0.0,
        'THI': (temp - ((0.55 - (0.55 * humidity / 100)) * (temp - 14.5))),  // Calculating THI
        'RH': humidity,
      });
    }
    print(dailyData);

    dailyData.forEach((key, value) {
    for (var map in value) {
      ranges.addAll(map);
    }
  });

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
        'wind_direction': windDirectionValues.reduce((a, b) => a + b) / windDirectionValues.length, // Average wind direction
        'wind_speed': windSpeedValues.reduce((a, b) => a + b),
        'rainfall': rainfallValues.reduce((a, b) => a + b), // Total rainfall
        'THI': THIValues.reduce((a, b) => a + b) / THIValues.length, // Average THI
        'RH': RHValues.reduce((a, b) => a < b ? a : b), // Minimum RH
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
  }
