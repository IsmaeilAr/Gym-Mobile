class InitStatusModel {
  final bool hasCoach;
  final bool hasProgram;
  final int coachId;
  final List<MyProgram> programType;

  InitStatusModel({
    required this.hasCoach,
    required this.hasProgram,
    required this.coachId,
    required this.programType,
  });

  factory InitStatusModel.fromJson(Map<String, dynamic> json) {
    return InitStatusModel(
      hasCoach: json['hasCoach'] == 'true',
      hasProgram: json['hasProgram'] == 'true',
      coachId: json['coachId'] ?? 0,
      programType: List<MyProgram>.from(json['programType'].map((x) => MyProgram.fromJson(x))),
    );
  }
}

class MyProgram {
  final int id;
  final int categoryId;
  final String name;
  final String file;
  final List imageUrl;
  final String type;
  final String createdAt;
  final String updatedAt;
  final Pivot pivot;

  MyProgram({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.file,
    required this.imageUrl,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory MyProgram.fromJson(Map<String, dynamic> json) {
    return MyProgram(
      id: json['id'],
      categoryId: json['categoryId'],
      name: json['name'],
      file: json['file'],
      imageUrl: json['imageUrl'],
      type: json['type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      pivot: Pivot.fromJson(json['pivot']),
    );
  }
}

class Pivot {
  final int playerId;
  final int programId;
  final int days;
  final String startDate;

  Pivot({
    required this.playerId,
    required this.programId,
    required this.days,
    required this.startDate,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      playerId: json['player_id'],
      programId: json['program_id'],
      days: json['days'],
      startDate: json['startDate'],
    );
  }
}
