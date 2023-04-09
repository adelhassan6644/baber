class ProfileModel{
  String? image;
  String? phone;
  int? cityId;
  String? cityName;
  String? version;
  ProfileModel({this.phone,this.image,this.cityId,this.cityName,this.version});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    phone = json['phone'];
    cityId = json['city_id'];
    cityName = json['city_name'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['phone'] = phone;
    data['city_id'] = cityId;
    data['city_name'] = cityName;
    data['version'] = version;
    return data;
  }
}