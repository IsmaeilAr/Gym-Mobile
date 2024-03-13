class PremiumStatusModel {
  final int id;

  // final int coachId;
  // final int playerId;
  final String type; // join, nutrition, training
  final String status; // waiting, accepted

  PremiumStatusModel({
    required this.id,
    // required this.coachId,
    // required this.playerId,
    required this.type,
    required this.status,
  });

  factory PremiumStatusModel.fromJson(Map<String, dynamic> json) {
    return PremiumStatusModel(
      id: json['id'] as int,
      // coachId: json['coachId'] as int,
      // playerId: json['playerId'] as int,
      type: json['type'] as String,
      status: json['status'] as String,
    );
  }
}
