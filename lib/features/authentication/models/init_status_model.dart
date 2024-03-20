import 'package:gym/features/profile/models/user_model.dart';
import '../../programs/model/program_model.dart';

class InitStatusModel {
  final bool hasCoach;
  final UserModel myCoach;
  final List<ProgramModel> myTrainingProgram;
  final List<ProgramModel> myNutritionProgram;

  InitStatusModel({
    required this.hasCoach,
    required this.myCoach,
    required this.myTrainingProgram,
    required this.myNutritionProgram,
  });

  factory InitStatusModel.fromJson(Map<String, dynamic> json) {
    final List<UserModel> coachList = List<UserModel>.from(
      json['myCoach']
          .map((coachJson) => UserModel.fromJson(coachJson['coach'])),
    );

    final List<ProgramModel> trainingProgramList =
        (json['sportProgram'] != null)
            ? List<ProgramModel>.from(
                json['sportProgram'].map((x) => ProgramModel.fromJson(x)))
            : [];

    final List<ProgramModel> nutritionProgramList =
        (json['foodProgram'] != null)
            ? List<ProgramModel>.from(
                json['foodProgram'].map((x) => ProgramModel.fromJson(x)))
            : [];

    return InitStatusModel(
      hasCoach: json['hasCoach'] == 'true',
      myCoach: coachList[0],
      myTrainingProgram: trainingProgramList,
      myNutritionProgram: nutritionProgramList,
    );
  }
}
