class ItemModel {
  int? id,price;
  String? image, title, address;

  ItemModel({this.id, this.price,this.image, this.title, this.address});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    title = json['title'];
    address = json['address'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['image'] = image;
    data['title'] = title;
    data['address'] = address;
    return data;
  }
}
