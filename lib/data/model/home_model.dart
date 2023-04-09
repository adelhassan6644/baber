class BannerModel {
  List<Banner>? banners;

  BannerModel({required this.banners});

  BannerModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      banners = [];
      json['data'].forEach((v) {
        banners!.add( Banner.fromJson(v));
      });

    }}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (banners != null) {
      data['data'] = banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Banner{
  int? id;
  String? image;
  String? body;
  String? productID;
  String? productType;

  Banner({
    this.id,
    this.image,
    this.body,
    this.productID,
    this.productType,
  });

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    body = json['body'];
    productID = json['product_id'];
    productType = json['product_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['body'] = body;
    data['product_id'] = productID;
    data['product_type'] = productType;
    return data;
  }
}

class HomeCategoryModel {

  List<HomeCategory>? homeCategories;

  HomeCategoryModel({required this.homeCategories});

  HomeCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      homeCategories = [];
      json['data'].forEach((v) {
        homeCategories!.add( HomeCategory.fromJson(v));
      });

    }}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (homeCategories != null) {
      data['data'] = homeCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class HomeCategory{
  int? id;
  String? image;
  String? name;


  HomeCategory({
    this.id,
    this.image,
    this.name,
  });

  HomeCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    return data;
  }
}


