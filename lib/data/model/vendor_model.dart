import 'item_model.dart';

class VendorModel {
  int? id;
  String? image, title, address;
  List<Menu>? menus;
  VendorModel({this.id,this.image, this.title, this.address,this.menus});

  VendorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    address = json['address'];
    image = json['image'];
    if (json['data'] != null) {
      menus = [];
      json['data'].forEach((v) {
        menus!.add( Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['address'] = address;
    if (menus != null) {
      data['data'] = menus!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menu {
  int? id;
  String?title;
  List<ItemModel>? product;


  Menu({this.id, this.title, this.product});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['data'] != null) {
      product = [];
      json['data'].forEach((v) {
        product!.add( ItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    if (product != null) {
      data['data'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
