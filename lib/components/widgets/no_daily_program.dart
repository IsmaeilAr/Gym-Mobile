import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/features/main_layout/main_layout_provider.dart';
import 'package:provider/provider.dart';
import '../styles/colors.dart';
import '../styles/decorations.dart';
import 'gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoDailyPrograms extends StatelessWidget {
  const NoDailyPrograms(
    this.isTraining, {
    super.key,
  });

  final bool isTraining;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.h,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.homeNoDailyProgramsTitle,
                style: const TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w600, color: grey)),
            const Gap(h: 8),
            Text(
              AppLocalizations.of(context)!.homeNoDailyProgramsSubtitle,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: lightGrey,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(
              h: 24,
            ),
            FindProgramButton(isTraining),
          ],
        ),
      ),
    );
  }
}

class FindProgramButton extends StatelessWidget {
  const FindProgramButton(this.isTraining, {super.key});

  final bool isTraining;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 296.w,
      height: 46.h,
      child: ElevatedButton(
        onPressed: () {
          context.read<MainLayoutProvider>().selectedIndex =
              1; // "1" is the index of programs screen
        },
        style: MyDecorations.myButtonStyle(dark),
        child: Text(
          isTraining
              ? AppLocalizations.of(context)!.homeNoDailyProgramsButton
              : AppLocalizations.of(context)!.homeNoDailyNutritionButton,
          style: MyDecorations.myButtonTextStyle(
              fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
