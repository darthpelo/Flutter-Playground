class Coord {
  double lat;
  double long;

  Coord({this.lat, this.long});

  factory Coord.fromJson(Map<String, dynamic> parsedJson) {
    return Coord(
      lat: parsedJson['lat'],
      long: parsedJson['long'],
    );
  }
}

class City {
  int id;
  String name;
  Coord coord;
  String country;

  City({this.name, this.id, this.coord, this.country});

  factory City.fromJson(Map<String, dynamic> parsedJson) {
    return City(
        id: parsedJson['id'],
        name: parsedJson['name'],
        coord: Coord.fromJson(parsedJson['coord']),
        country: parsedJson['country'],
    );
  }
}

class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather({this.id, this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> parsedJson) {
    return Weather(
      id: parsedJson['id'],
      main: parsedJson['main'],
      description: parsedJson['description'],
      icon: parsedJson['icon'],
    );
  }
}

class ForecastData {
  int dt;
  Weather weather;

  ForecastData({this.dt, this.weather});

  factory ForecastData.fromJson(Map<String, dynamic> parsedJson) {
    return ForecastData(
      dt: parsedJson['dt'],
      weather: Weather.fromJson(parsedJson['weather'][0]),
    );
  }
}

class Forecast {
  final List<ForecastData> forecastList;
  final City city;

  Forecast({this.forecastList, this.city});

  factory Forecast.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['list'] as List;
    print(list.runtimeType);
    List<ForecastData> forecastList = list.map((i) => ForecastData.fromJson(i)).toList();
    print(forecastList);
    return Forecast(
      forecastList: forecastList,
      city: City.fromJson(parsedJson['city']),
    );
  }
}
