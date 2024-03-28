import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/features/profile/models/user_model.dart';
import '../styles/colors.dart';
import '../styles/decorations.dart';
import 'cancel_button.dart';

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
        const CancelButton(),
        SizedBox(width: 5.w),
        MaterialButton(
          onPressed: () {
            doSelectCoach();
            Navigator.pop(context);
          },
          color: primaryColor,
          child: Text(
            AppLocalizations.of(context)!.coachProfileSetCoach,
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
      content: Text(
        "${AppLocalizations.of(context)!.changeCoachConfirmation} ${coach.name}",
        // removed: ${AppLocalizations.of(context)!.changeCoachConfirmation2}
        style: MyDecorations.coachesTextStyle,
      ),
    );
  }
}
