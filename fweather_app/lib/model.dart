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

class MainSimpleInformation {
  double temp;
  String tempMin;
  String tempMax;
  String pressure;
  int humidity;

  double a = 0;

  MainSimpleInformation(
      {this.temp, this.tempMin, this.tempMax, this.pressure, this.humidity});

  factory MainSimpleInformation.fromJson(Map<String, dynamic> parsedJson) {

    return MainSimpleInformation(
        temp: double.parse(parsedJson['temp'].toString()),
        tempMin: parsedJson['temp_min'].toString(),
        tempMax: parsedJson['temp_max'].toString(),
        pressure: parsedJson['pressure'].toString(),
        humidity: parsedJson['humidity']);
  }
}

class MainFullInformation {
  double temp;
  String tempMin;
  String tempMax;
  String pressure;
  String seaLevel;
  String groundLevel;
  int humidity;

  MainFullInformation(
      {this.temp,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.seaLevel,
      this.groundLevel,
      this.humidity});

  factory MainFullInformation.fromJson(Map<String, dynamic> parsedJson) {
    return MainFullInformation(
        temp: double.parse(parsedJson['temp'].toString()),
        tempMin: parsedJson['temp_min'].toString(),
        tempMax: parsedJson['temp_max'].toString(),
        pressure: parsedJson['pressure'].toString(),
        seaLevel: parsedJson['sea_level'].toString(),
        groundLevel: parsedJson['grnd_level'].toString(),
        humidity: parsedJson['humidity']);
  }
}

class CityForecast {
  int timeStamp;
  String name;
  Weather weather;
  MainSimpleInformation mainInformation;

  CityForecast({this.timeStamp, this.name, this.weather, this.mainInformation});

  factory CityForecast.fromJson(Map<String, dynamic> parsedJson) {
    return CityForecast(
      timeStamp: parsedJson['dt'],
      name: parsedJson['name'],
      weather: Weather.fromJson(parsedJson['weather'][0]),
      mainInformation: MainSimpleInformation.fromJson(parsedJson['main']),
    );

  }
}

class ForecastData {
  int timeStamp;
  Weather weather;
  MainFullInformation mainInformation;

  ForecastData({this.timeStamp, this.weather, this.mainInformation});

  factory ForecastData.fromJson(Map<String, dynamic> parsedJson) {
    return ForecastData(
      timeStamp: parsedJson['dt'],
      weather: Weather.fromJson(parsedJson['weather'][0]),
      mainInformation: MainFullInformation.fromJson(parsedJson['main']),
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
