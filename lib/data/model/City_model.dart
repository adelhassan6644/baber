class CityModel{
  List<City>? cities;

  CityModel({required this.cities});

  CityModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      cities = [];
      json['data'].forEach((v) {
        cities!.add( City.fromJson(v));
      });

    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cities != null) {
      data['data'] = cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  int? id;
  String? name;

  City({this.id, this.name});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

}
