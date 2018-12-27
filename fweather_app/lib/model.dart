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

class MainInformation {
  String temp;
  String tempMin;
  String tempMax;
  String pressure;
  String seaLevel;
  String groundLevel;
  int humidity;

  MainInformation(
      {this.temp,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.seaLevel,
      this.groundLevel,
      this.humidity});

  factory MainInformation.fromJson(Map<String, dynamic> parsedJson) {
    return MainInformation(
      temp: parsedJson['temp'].toString(),
      tempMin: parsedJson['temp_min'].toString(),
      tempMax: parsedJson['temp_max'].toString(),
      pressure: parsedJson['pressure'].toString(),
      seaLevel: parsedJson['sea_level'].toString(),
      groundLevel: parsedJson['grnd_level'].toString(),
      humidity: parsedJson['humidity']
    );
  }
}

class ForecastData {
  int timeStamp;
  Weather weather;
  MainInformation mainInformation;

  ForecastData({this.timeStamp, this.weather, this.mainInformation});

  factory ForecastData.fromJson(Map<String, dynamic> parsedJson) {
    return ForecastData(
      timeStamp: parsedJson['dt'],
      weather: Weather.fromJson(parsedJson['weather'][0]),
      mainInformation: MainInformation.fromJson(parsedJson['main']),
    );
  }
}

class Forecast {
  final List<ForecastData> forecastList;
  final City city;

  Forecast({this.forecastList, this.city});

  factory Forecast.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['list'] as List;

    List<ForecastData> forecastList =
        list.map((i) => ForecastData.fromJson(i)).toList();

    return Forecast(
      forecastList: forecastList,
      city: City.fromJson(parsedJson['city']),
    );
  }
}
