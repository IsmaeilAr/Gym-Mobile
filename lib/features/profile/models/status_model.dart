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









