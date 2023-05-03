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

class NotificationData {
  int? id;
  String? userId;
  String? title;
  String? message;
  String? status;
  String? alertId;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationData({
    this.id,
    this.title,
    this.message,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    id: json["id"],
    title: json["title"],
    message: json["message"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "message": message,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
