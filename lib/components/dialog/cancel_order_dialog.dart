import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../features/programs/provider/program_provider.dart';
import '../styles/colors.dart';
import '../styles/decorations.dart';
import 'cancel_button.dart';

class RevokeProgramRequestDialog extends StatelessWidget {
  const RevokeProgramRequestDialog(
    this.orderId, {
    super.key,
  });

  final int orderId;

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
            context.read<ProgramProvider>().callCancelOrder(context, orderId);
            Navigator.pop(context);
          },
          color: primaryColor,
          child: Text(
            AppLocalizations.of(context)!.revoke,
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
      content: Text(
        AppLocalizations.of(context)!.revokeRequestConfirmation,
        style: MyDecorations.coachesTextStyle,
      ),
    );
  }
}
