class ArticleModel {
  final int id;
  final String title;
  final String content;
  bool isFavorite;

  ArticleModel({
    required this.id,
    required this.title,
    required this.content,
    required this.isFavorite,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'] ?? 0,
      title: json['title'],
      content: json['content'] ?? '',
      isFavorite: json['isFavourite'] as bool,
    );
  }

}
