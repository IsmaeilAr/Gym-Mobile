import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/programs/model/program_model.dart';
import '../styles/colors.dart';
import '../styles/decorations.dart';
import '../dialog/cancel_button.dart';

class SelectProgramDialog extends StatelessWidget {
  final ProgramModel program;
  final VoidCallback doSelectProgram;

  const SelectProgramDialog(this.doSelectProgram,
      {super.key, required this.program});

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
            doSelectProgram();
          },
          color: primaryColor,
          child: Text(
            AppLocalizations.of(context)!.set,
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
      content: Text(
        AppLocalizations.of(context)!.setProgramConfirmation,
        style: MyDecorations.coachesTextStyle,
      ),
    );
  }
}

class DeselectProgramDialog extends StatelessWidget {
  final ProgramModel program;
  final VoidCallback doDeSelectProgram;

  const DeselectProgramDialog(this.doDeSelectProgram,
      {super.key, required this.program});

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
            doDeSelectProgram();
          },
          color: primaryColor,
          child: Text(
            AppLocalizations.of(context)!.deselect,
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
      content: Text(
        AppLocalizations.of(context)!.deselectProgramConfirmation,
        style: MyDecorations.coachesTextStyle,
      ),
    );
  }
}
