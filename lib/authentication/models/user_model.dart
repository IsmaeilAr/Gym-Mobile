class UserModel {
  final int id;
  final String name;
  final String phoneNumber;
  final DateTime birthDate;
  final String role;

  UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.birthDate,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      role: json['role'] as String,
    );
  }
}
