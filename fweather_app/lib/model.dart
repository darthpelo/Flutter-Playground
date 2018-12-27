class City {
  final int cityId;
  final String name;
  final String description;

  City({this.cityId, this.name, this.description});

  factory City.fromJson(Map<String, dynamic> json) {
    var temp = json['weather'];

    return City(
      cityId: json['id'],
      name: json['name'],
      description: temp[0]['description'],
    );
  }
}