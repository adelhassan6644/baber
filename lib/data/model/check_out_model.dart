class CheckOutModel {
  int? orderId;
  String? url;

  CheckOutModel({this.orderId, this.url});

  CheckOutModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['url'] = url;
    return data;
  }
}
