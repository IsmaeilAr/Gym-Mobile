import 'package:flutter/material.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.pop(context);
      },
      color: Colors.black,
      child: Text(
        AppLocalizations.of(context)!.cancel,
        style: MyDecorations.programsTextStyle,
      ),
    );
  }
}
