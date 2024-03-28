
class NotificationModel {
  final int id;
  final String type;
  final String title;
  final String content;
  final DateTime date;
  final DateTime createdAt;

  NotificationModel(
      {required this.id,
      required this.type,
      required this.title,
      required this.content,
      required this.date,
      required this.createdAt});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      type: json['type'] ?? "",
      title: json['title'] ?? "",
      content: json['contect'] ?? "",
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
