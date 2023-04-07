class LocationModel {
  List<Location>? locations;

  LocationModel({this.locations});

  LocationModel.fromJson(Map<String, dynamic> json) {
    locations = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['locations'] = locations;
    return data;
  }

}

class Location {
  int? id;
  String? location;

  Location({this.id, this.location});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['location'] = location;
    return data;
  }

}
