class PlayerMetricsModel {
  final int id;
  final String gender;
  final DateTime birthDate;
  final int age;
  final int weight;
  final int waistMeasurement;
  final int neck;
  final int height;
  final double bfp;

  PlayerMetricsModel({
    required this.id,
    required this.gender,
    required this.birthDate,
    required this.age,
    required this.weight,
    required this.waistMeasurement,
    required this.neck,
    required this.height,
    required this.bfp,
  });

  factory PlayerMetricsModel.fromJson(Map<String, dynamic> json) {
    return PlayerMetricsModel(
      id: json['id'],
      gender: json['gender'] ?? "not set",
      birthDate: DateTime.parse(json['birthDate']),
      age: json['age'] ?? 0,
      weight: json['weight'] ?? 0,
      waistMeasurement: json['waist Measurement'] ?? 0,
      neck: json['neck'] ?? 0,
      height: json['height'] ?? 0,
      bfp: json['BFP'].toDouble() ?? 0,
    );
  }
}