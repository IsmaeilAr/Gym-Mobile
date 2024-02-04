class ReportModel {
  final int id;
  final int userId;
  final String title;
  final String text;
  final DateTime createdAt;
  final ReporterModel user;

  ReportModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.text,
    required this.createdAt,
    required this.user,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      title: json['title'],
      text: json['text'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      user: ReporterModel.fromJson(json['user']),
    );
  }

  static List<ReportModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => ReportModel.fromJson(json)).toList();
  }
}

class ReporterModel {
  final int id;
  final String name;
  final String phoneNumber;
  final String role;
  final List<ReporterImage> images;

  ReporterModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.role,
    required this.images,
  });

  factory ReporterModel.fromJson(Map<String, dynamic> json) {
    return ReporterModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      role: json['role'] ?? '',
      images: (json['image'] as List<dynamic>?)
          ?.map((image) => ReporterImage.fromJson(image))
          .toList() ??
          [],
    );
  }
}

class ReporterImage {
  final int id;
  final String image;

  ReporterImage({
    required this.id,
    required this.image,
  });

  factory ReporterImage.fromJson(Map<String, dynamic> json) {
    return ReporterImage(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
    );
  }
}
