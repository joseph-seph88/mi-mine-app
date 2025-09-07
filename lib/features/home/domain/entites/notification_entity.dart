class NotificationEntity {
  final int? id;
  final String? type;
  final String? title;
  final String? message;
  final String? time;
  final bool? isRead;
  final String? avatar;

  NotificationEntity({
    this.id,
    this.type,
    this.title,
    this.message,
    this.time,
    this.isRead,
    this.avatar,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      type: json['type'],
      title: json['title'],
      message: json['message'],
      time: json['time'],
      isRead: json['isRead'],
      avatar: json['avatar'],
    );
  }

  NotificationEntity copyWith({
    int? id,
    String? type,
    String? title,
    String? message,
    String? time,
    bool? isRead,
    String? avatar,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      time: time ?? this.time,
      isRead: isRead ?? this.isRead,
      avatar: avatar ?? this.avatar,
    );
  }

  @override
  String toString() {
    return 'NotificationEntity(id: $id, type: $type, title: $title, message: $message, time: $time, isRead: $isRead, avatar: $avatar)';
  }
}
