import '../../programs/model/program_model.dart';

class InitStatus {
  bool hasCoach;
  bool hasProgram;
  List<ProgramModel>? programs;

  InitStatus({
    required this.hasCoach,
    required this.hasProgram,
    required this.programs,
  });

  factory InitStatus.fromJson(Map<String, dynamic> json) {
    return InitStatus(
      hasCoach: json['hasCoach'].toString().toLowerCase() == 'true',
      hasProgram: json['hasProgram'].toString().toLowerCase() == 'true',
      programs: json['programType'],
    );
  }
}




class ActivePlayer {
  final int userId;
  final int dayId;
  final String startTime;
  final String? endTime;
  final String status;
  final int id;
  final int isCoach;
  final User user;

  ActivePlayer({
    required this.userId,
    required this.dayId,
    required this.startTime,
    this.endTime,
    required this.status,
    required this.id,
    required this.isCoach,
    required this.user,
  });

  factory ActivePlayer.fromJson(Map<String, dynamic> json) {
    return ActivePlayer(
      userId: json['userId'],
      dayId: json['dayId'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      status: json['status'],
      id: json['id'],
      isCoach: json['isCoach'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String name;
  final String phoneNumber;
  final String birthDate;
  final String role;
  final int rate;
  final String expiration;
  final int finance;
  final String isPaid;

  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.birthDate,
    required this.role,
    required this.rate,
    required this.expiration,
    required this.finance,
    required this.isPaid,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      birthDate: json['birthDate'],
      role: json['role'],
      rate: json['rate'],
      expiration: json['expiration'],
      finance: json['finance'],
      isPaid: json['is_paid'],
    );
  }
}

class Traffic {
  final bool isTraffic;

  Traffic({required this.isTraffic});

  factory Traffic.fromJson(Map<String, dynamic> json) {
    return Traffic(
      isTraffic: json['isTraffic'],
    );
  }
}




