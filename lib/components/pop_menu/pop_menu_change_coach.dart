import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/widgets/menu_item_model.dart';
import 'package:gym/features/profile/models/user_model.dart';
import '../dialog/rate_coach_dialog.dart';
import '../styles/colors.dart';
import '../styles/decorations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Define a class to manage the menu items
class ChangeCoachMenuItems {
  static const itemChangeCoach =
      MenuItemModel(text: 'Change coach', icon: Icons.create);
  static const itemUnAssign =
      MenuItemModel(text: 'Unassign', icon: Icons.close);
  static const itemRate = MenuItemModel(text: 'Rate', icon: Icons.star);

  // Define a list of all menu items
  static const List<MenuItemModel> getChangeMenuItems = [
    itemChangeCoach,
    itemUnAssign,
    itemRate,
  ];
}

// Function to handle the selection of menu items
void onSelectedChangeCoach(
    BuildContext context, MenuItemModel item, UserModel coach) {
  switch (item) {
    case ChangeCoachMenuItems.itemChangeCoach:
      showDialog(
        context: context,
        builder: (context) => ChangeCoachDialog(coach: coach),
      );
      break;
    case ChangeCoachMenuItems.itemUnAssign:
      showDialog(
        context: context,
        builder: (context) => UnAssignCoachDialog(coach: coach),
      );
      break;
    case ChangeCoachMenuItems.itemRate:
      showDialog(
        context: context,
        builder: (context) => RateStarsCoachDialog(
          coach: coach,
        ),
      );
      break;
  }
}

// Define a dialog for changing coach
class ChangeCoachDialog extends StatelessWidget {
  final UserModel coach;

  const ChangeCoachDialog({super.key, required this.coach});

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
          onPressed: () {},
          color: primaryColor,
          child: Text(
            AppLocalizations.of(context)!.change,
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
      content: Text(
        "${AppLocalizations.of(context)!.coachProfileChangeCoachConfirmation} ${coach.name} ${AppLocalizations.of(context)!.coachProfileChangeCoachConfirmation2}",
        style: MyDecorations.coachesTextStyle,
      ),
    );
  }
}

// Define a dialog for unassigning coach
class UnAssignCoachDialog extends StatelessWidget {
  final UserModel coach;

  const UnAssignCoachDialog({super.key, required this.coach});

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
            "Cancel",
            style: MyDecorations.programsTextStyle,
          ),
        ),
        SizedBox(width: 5.w),
        MaterialButton(
          onPressed: () {},
          color: primaryColor,
          child: Text(
            "Unassign",
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
      content: Text(
        "Are you sure you want to unassign your current coach?",
        style: MyDecorations.coachesTextStyle,
      ),
    );
  }
}

// Define a dialog for rating coach
