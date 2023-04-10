import 'item_model.dart';

class SearchModel {
  List<ItemModel>? products;
  List<ItemModel>? vendors;

  SearchModel({this.products, this.vendors});

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products!.add(ItemModel.fromJson(v));
      });
    }
    if (json['stores'] != null) {
      vendors =[];
      json['stores'].forEach((v) {
        vendors!.add(ItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (vendors != null) {
      data['stores'] = vendors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}