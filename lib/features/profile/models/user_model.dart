import 'package:gym/utils/helpers/api/api_helper.dart';

class UserModel {
  int id;
  String name;
  String phoneNumber;
  DateTime birthDate;
  String role;
  String description;
  double rate;
  DateTime expiration;
  double finance;
  // DateTime createdAt;
  bool isPaid;
  List<ImageModel> images;

  UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.birthDate,
    required this.role,
    required this.description,
    required this.rate,
    required this.expiration,
    required this.finance,
    // required this.createdAt,
    required this.isPaid,
    required this.images,
  });



  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"] ?? 0,
    name: json["name"],
    phoneNumber: json["phoneNumber"],
    birthDate: DateTime.parse(json["birthDate"]),
    role: json["role"],
    description: json["description"] ?? "",
    rate: (json["rate"] ?? 0).toDouble(),
    expiration: DateTime.parse(json["expiration"]),
    finance: (json["finance"] ?? 0).toDouble(),
    // createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    isPaid: json["is_paid"] == "paid", // Parse string "paid" to boolean
    images: json["image"] != null ? List<ImageModel>.from(json["image"].map((x) => ImageModel.fromJson(x))) : [],
  );


}

class ImageModel {
  final int id;
  final String image;

  ImageModel({
    required this.id,
    required this.image,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      image: "${ApiHelper.imageUrl}${json['image']}",
    );
  }
}