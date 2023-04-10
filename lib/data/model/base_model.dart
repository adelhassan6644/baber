
import 'item_model.dart';

class BaseModel{
  List<ItemModel>? items;

  BaseModel({required this.items});

  BaseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      items = [];
      json['data'].forEach((v) {
        items!.add( ItemModel.fromJson(v));
      });

    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['data'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

