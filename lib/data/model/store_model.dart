import 'item_model.dart';

class StoreModel {
  List<Menus>? menus;
  String? id, logo, image, name, description, phone, email,cityId;
  bool? active;

  StoreModel(
      {this.id,
        this.logo,
        this.image,
        this.name,
        this.description,
        this.phone,
        this.email,
        this.cityId,
        this.active,
        this.menus});

  StoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'];
    description = json['description'];
    logo = json['logo'];
    image = json['image'];
    phone = json['phone'];
    email = json['email'];
    cityId = json['city_id'].toString();
    active = (json['active'] == 1) ? true : false;

    if (json['menus'] != null) {
      menus = [];
      json['menus'].forEach((v) {
        menus!.add(Menus.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['logo'] = logo;
    data['image'] = image;
    data['name'] = name;
    data['description'] = description;
    data['phone'] = phone;
    data['email'] = email;
    data['city_id'] = cityId.toString();
    data['active'] = active == true ? 1 : 0;
    if (menus != null) {
      data['menus'] = menus!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}


