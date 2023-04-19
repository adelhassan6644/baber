import 'package:baber/data/model/store_model.dart';

class BannerModel {
  List<Banner>? banners;
  BannerModel({this.banners});

  BannerModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      banners = [];
      json['data'].forEach((v) {
        banners!.add(Banner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (banners != null) {
      data['data'] = banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banner {
  String? id, image, body, productId, type;
  StoreModel? store;
  Banner(
      {this.id, this.image, this.body, this.type, this.productId, this.store});

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    image = json['image'];
    body = json['body'];
    productId = json['product_id'];
    type = json['slider_type'];
    if (json['store'] != null) store = StoreModel.fromJson(json['store']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['body'] = body;
    data['product_id'] = productId;
    data['slider_type'] = type;
    if (store != null) data["store"] = store!.toJson();
    return data;
  }
}
