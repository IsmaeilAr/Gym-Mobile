import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../features/programs/provider/program_provider.dart';
import '../styles/colors.dart';
import '../styles/decorations.dart';
import 'cancel_button.dart';

class AskForNewProgramDialog extends StatelessWidget {
  const AskForNewProgramDialog(
    this.genre,
    this.coachId, {
    super.key,
  });

  final String genre;
  final int coachId;

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
            context
                .read<ProgramProvider>()
                .callRequestPremiumProgram(context, coachId, genre);
            Navigator.pop(context);
          },
          color: primaryColor,
          child: Text(
            AppLocalizations.of(context)!.send,
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
      content: Text(
        (genre == 'sport')
            ? AppLocalizations.of(context)!.requestProgramSport
            : AppLocalizations.of(context)!.requestProgramFood,
        style: MyDecorations.coachesTextStyle,
      ),
    );
  }
}
