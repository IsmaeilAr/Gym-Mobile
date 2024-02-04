import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/colors.dart';
import '../styles/decorations.dart';

class AlertDialogSelect extends StatelessWidget {
  final Function onConfirm;
  const AlertDialogSelect({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: black,
      surfaceTintColor: black,
      elevation: 24.0,
      actions: [
        MaterialButton(
          onPressed: () {},
          child: Text(
            "Cancel",
            style: MyDecorations.programsTextStyle,
          ),
          color: black,
        ),
        SizedBox(width: 5.w),
        MaterialButton(
          onPressed: () {
            onConfirm();
          },
          child: Text(
            "Set",
            style: MyDecorations.coachesTextStyle,
          ),
          color: primaryColor,
        ),
      ],
      content: Text(
        "Are you sure you want to set this program as your daily one?",
        style: MyDecorations.coachesTextStyle,
      ),
    );
  }
}

class AlertDialogUnSelect extends StatelessWidget {
  final Function onConfirm;
  const AlertDialogUnSelect({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: black,
      surfaceTintColor: black,
      elevation: 24.0,
      actions: [
        MaterialButton(
          onPressed: () {},
          child: Text(
            "Cancel",
            style: MyDecorations.programsTextStyle,
          ),
          color: black,
        ),
        SizedBox(width: 5.w),
        MaterialButton(
          onPressed: () {
            onConfirm();
          },
          child: Text(
            "Deselect",
            style: MyDecorations.coachesTextStyle,
          ),
          color: primaryColor,
        ),
      ],
      content: Text(
        "Are you sure you want to deselect this program? It will not be your daily program once you deselect it.",
        style: MyDecorations.coachesTextStyle,
      ),
    );
  }
}