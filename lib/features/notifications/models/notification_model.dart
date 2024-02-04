import 'package:gym/utils/extensions/time_formatter.dart';

class NotificationModel {
  final int id;
  final String title;
  final String message;
  final String imgUrl;
  final String timestamp;
  final bool isUrgent;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.imgUrl,
    required this.timestamp,
    required this.isUrgent,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      imgUrl: json['imgUrl'],
      timestamp: DateTime.parse(json['timestamp']).currentFormatted(),
      isUrgent: json['isUrgent'] == 'isUrgent', // todo backend add
    );
  }
}
