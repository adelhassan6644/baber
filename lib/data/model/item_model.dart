import 'package:baber/data/model/store_model.dart';

class ItemModel {
  int? qty;
  List<Menus>? menus;
  String? id,
      price,
      logo,
      image,
      name,
      address,
      body,
      cityName,
      phone,
      email,
      categoryId;
  bool? active,isAdded;
  Menus? menu;
  List<Addon>? addons;
  StoreModel? store;

  ItemModel(
      {this.id,
      this.qty = 1,
      this.body,
      this.price,
      this.logo,
      this.image,
      this.cityName,
      this.name,
      this.address,
      this.categoryId,
      this.phone,
      this.email,
      this.active,
      this.isAdded,
      this.menu,
      this.addons,
      this.menus,
      this.store});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    categoryId = json['category_id'].toString();
    price = json['price'];
    qty = json['qty'] ?? 1;
    name = json['name'];
    cityName = json['city_name'];
    address = json['address'];
    logo = json['logo'];
    image = json['image'];
    phone = json['phone'];
    email = json['email'];
    body = json['body'];
    active = (json['active'] == 0) ? false : true;
    isAdded = json['is_add']?? false ;

    if (json['store'] != null) {
      store = StoreModel.fromJson(json['store']);
    }

    if (json['menu'] != null) {
      menu = Menus.fromJson(json['menu']);
    }

    if (json['addons'] != null) {
      addons = [];
      json['addons'].forEach((v) {
        addons!.add(Addon.fromJson(v));
      });
    }

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
    data['qty'] = qty ?? 1;
    data['category_id'] = categoryId;
    data['price'] = price;
    data['logo'] = logo;
    data['image'] = image;
    data['name'] = name;
    data['city_name'] = cityName;
    data['address'] = address;
    data['phone'] = phone;
    data['email'] = email;
    data['body'] = body;
    if (menu != null) data['menu'] = menu?.toJson();
    data['active'] = active == true ? 1: 0;
    data['is_dded'] = isAdded == true ? 1 : 0;
    if (menus != null) {
      data['menus'] = menus!.map((v) => v.toJson()).toList();
    }
    if (store != null) {
      data['store'] = store!.toJson();
    }

    if (addons != null) {
      data['addons'] = addons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menus {
  int? id;
  String? name;

  Menus({this.id, this.name});

  Menus.fromJson(Map<String, dynamic> json) {
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

class Addon {
  int? id;
  String? name, price, image;
  bool? isSelected;

  Addon({this.id, this.name, this.isSelected, this.image, this.price});

  Addon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'].toString();
    image = json['image'];
    isSelected = json['is_selected']??false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    data['is_selected'] = isSelected;
    return data;
  }

}
