class ItemModel {
  int? qty;
  List<Menus>? menus;
  String? id,
      price,
      logo,
      image,
      name,
      description,
      address,
      body,
      cityName,
      phone,
      email,
      productID,
      productType,
      categoryId;
  bool? active;
  Menus? menu;
  List<Addon>? addons;

  ItemModel(
      {this.id,
      this.qty = 1,
      this.body,
      this.productID,
      this.productType,
      this.price,
      this.logo,
      this.image,
      this.cityName,
      this.name,
      this.description,
      this.address,
      this.categoryId,
      this.phone,
      this.email,
      this.active,
      this.menu,
      this.addons,
      this.menus});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    categoryId = json['category_id'].toString();
    price = json['price'];
    qty = json['qty']??1;
    name = json['name'];
    description = json['description'];
    cityName = json['city_name'];
    address = json['address'];
    logo = json['logo'];
    image = json['image'];
    phone = json['phone'];
    email = json['email'];
    body = json['body'];
    productID = json['product_id'];
    productType = json['product_type'];

    active = (json['active'] == 0) ? true : false;

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
    data['qty'] = qty??1;
    data['category_id'] = categoryId;
    data['price'] = price;
    data['logo'] = logo;
    data['image'] = image;
    data['name'] = name;
    data['description'] = description;
    data['city_name'] = cityName;
    data['address'] = address;
    data['phone'] = phone;
    data['email'] = email;
    data['body'] = body;
    data['product_id'] = productID;
    data['product_type'] = productType;
    if (menu != null) data['menu'] = menu?.toJson();
    data['active'] = active == true ? 0 : 1;
    if (menus != null) {
      data['menus'] = menus!.map((v) => v.toJson()).toList();
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

  Addon({this.id, this.name, this.isSelected = false, this.image, this.price});

  Addon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    isSelected = false;
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
