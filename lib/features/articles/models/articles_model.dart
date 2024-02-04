class ArticleModel {
  final int id;
  final String title;
  final String content;
  final DateTime createdAt;
  bool isFavorite;
  final AuthorModel user;

  ArticleModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.isFavorite,
    required this.user,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'] ?? 0,
      title: json['title'],
      content: json['content'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? ''),
      isFavorite: json['isFavorite'] ?? false,
      user: AuthorModel.fromJson(json['user']),
    );
  }

}

class AuthorModel {
  final int id;
  final String name;
  final String phoneNumber;
  final String role;
  final List<AuthorImage> images;

  AuthorModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.role,
    required this.images,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      role: json['role'] ?? '',
      images: (json['image'] as List<dynamic>?)
          ?.map((image) => AuthorImage.fromJson(image))
          .toList() ??
          [],
    );
  }
}

class AuthorImage {
  final int id;
  final String image;

  AuthorImage({
    required this.id,
    required this.image,
  });

  factory AuthorImage.fromJson(Map<String, dynamic> json) {
    return AuthorImage(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
    );
  }
}
