class OrdersModel {
  bool? status;
  Data? data;

  OrdersModel({this.status, this.data});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<OrderItem>? orders;

  Data({this.orders});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      orders = [];
      json['data'].forEach((v) {
        orders!.add(OrderItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['data'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItem {
  String? id;
  String? orderId;
  String? userId;
  String? storeId;
  String? storeName;
  int? status;
  String? deliveryFees;
  String? orderDate;
  String? subTotal;
  String? total;
  DateTime? createdAt;
  String? updatedAt;

  OrderItem(
      {this.id,
      this.orderId,
      this.userId,
      this.storeId,
      this.storeName,
      this.status,
      this.deliveryFees,
      this.orderDate,
      this.subTotal,
      this.total,
      this.createdAt,
      this.updatedAt});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    status = json['status'];
    deliveryFees = json['delivery_fees'];
    orderDate = json['order_date'];
    subTotal = json['subTotal'];
    total = json['total'];
    createdAt = json['created_at'] != null
        ? DateTime.parse(json['created_at'])
        : DateTime.now();
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['user_id'] = userId;
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['status'] = status;
    data['delivery_fees'] = deliveryFees;
    data['order_date'] = orderDate;
    data['subTotal'] = subTotal;
    data['total'] = total;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
