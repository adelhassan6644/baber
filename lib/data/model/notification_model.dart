class NotificationModel {
  List<NotificationData>? notifications;

  NotificationModel({required this.notifications});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      notifications = [];
      json['data'].forEach((v) {
        notifications!.add( NotificationData.fromJson(v));
      });

    }}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notifications != null) {
      data['data'] = notifications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class NotificationData{
  int? id;
  String? image;
  String? body;
  String? createdAt;
  String? productID;
  String? productType;

  NotificationData({
    this.id,
    this.image,
    this.createdAt,
    this.body,
    this.productID,
    this.productType,
  });

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    body = json['body'];
    createdAt = json['created_at'];
    productID = json['product_id'];
    productType = json['product_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['body'] = body;
    data['created_at'] = createdAt;
    data['product_id'] = productID;
    data['product_type'] = productType;
    return data;
  }
}