import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/features/profile/provider/profile_provider.dart';
import 'package:gym/features/programs/widgets/program_card.dart';
import 'package:provider/provider.dart';
import '../model/category_model.dart';
import '../model/program_model.dart';
import '../provider/program_provider.dart';

class ProgramsList extends StatelessWidget {
  const ProgramsList(
      {super.key, required this.category, required this.isWithCoach});

  final TrainingCategoryModel category;
  final bool isWithCoach;

  @override
  Widget build(BuildContext context) {
    int trainingId = 0;
    int nutritionId = 0;
    if (context.read<ProfileProvider>().status.myTrainingProgram.isNotEmpty) {
      trainingId =
          context.read<ProfileProvider>().status.myTrainingProgram[0].id;
    }
    if (context.read<ProfileProvider>().status.myNutritionProgram.isNotEmpty) {
      nutritionId =
          context.read<ProfileProvider>().status.myNutritionProgram[0].id;
    }
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.h,
        horizontal: 14.w,
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: (isWithCoach)
                  ? context.watch<ProgramProvider>().myCoachPrograms.length
                  : (category.type == "sport")
                      ? context.watch<ProgramProvider>().sportProgramList.length
                      : context
                          .watch<ProgramProvider>()
                          .nutritionProgramList
                          .length,
              itemBuilder: (context, index) {
                ProgramModel program;
                bool isMyProgram = false;
                (isWithCoach)
                    ? {
                        program = context
                            .watch<ProgramProvider>()
                            .myCoachPrograms[index]
                      }
                    : (category.type == "sport")
                        ? {
                            program = context
                                .watch<ProgramProvider>()
                                .sportProgramList[index]
                          }
                        : {
                            program = context
                                .watch<ProgramProvider>()
                                .nutritionProgramList[index]
                          };
                if (program.id == trainingId || program.id == nutritionId) {
                  isMyProgram = true;
                }
                // isMyProgram = true;
                return ProgramCard(program, isMyProgram);
              },
            ),
          ),
        ],
      ),
    );
  }
}
