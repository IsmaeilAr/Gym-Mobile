import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/features/programs/model/program_model.dart';
import 'package:page_transition/page_transition.dart';
import '../../features/programs/screens/program_pdf_screen.dart';
import '../styles/colors.dart';
import 'net_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DailyProgramCard extends StatelessWidget {
  const DailyProgramCard(
    this.program, {
    super.key,
  });

  final ProgramModel program;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: PDFScreen(
                  programName: program.name,
                  programFileName: program.file,
                )));
      },
      child: Container(
        width: 332.w,
        height: 168.h,
        margin: EdgeInsets.symmetric(vertical: 6.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.sp),
            image: DecorationImage(
                image: NetworkImage(
              program.imageUrl,
            ))),
        child: Align(
          alignment: AlignmentDirectional.bottomStart,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Text(
                program.type == 'sport'
                    ? AppLocalizations.of(context)!.homeDailyProgramCardTitle
                    : AppLocalizations.of(context)!.homeDailyNutritionCardTitle,
                style: TextStyle(
                    color: lightGrey,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              )),
        ),
      ),
    );
  }
}
