import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/features/profile/models/user_model.dart';
import '../styles/colors.dart';
import '../styles/decorations.dart';

class SelectCoachDialog extends StatelessWidget {
  final UserModel coach;
  final VoidCallback doSelectCoach;

  const SelectCoachDialog(this.doSelectCoach, {super.key, required this.coach});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: black,
      surfaceTintColor: black,
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: black,
          child: Text(
            AppLocalizations.of(context)!.cancel,
            style: MyDecorations.programsTextStyle,
          ),
        ),
        SizedBox(width: 5.w),
        MaterialButton(
          onPressed: () {
            doSelectCoach();
          },
          color: primaryColor,
          child: Text(
            "Set Coach",
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
      content: Text(
        "Are you sure you want to set coach name as your coach ?",
        //todo localize
        style: MyDecorations.coachesTextStyle,
      ),
    );
  }
}
