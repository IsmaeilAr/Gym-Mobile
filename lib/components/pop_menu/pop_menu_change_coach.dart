import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/pop_menu/menu_item_model.dart';
import 'package:gym/features/coaches/provider/coach_provider.dart';
import 'package:gym/features/profile/models/user_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../features/coaches/screens/all_coaches_screen.dart';
import '../dialog/cancel_button.dart';
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
        const CancelButton(),
        SizedBox(width: 5.w),
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeftWithFade,
                  child: const AllCoachesScreen(),
                ));
          },
          color: primaryColor,
          child: Text(
            AppLocalizations.of(context)!.change,
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
      content: Text(
        AppLocalizations.of(context)!.coachProfileChangeCoachConfirmation,
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
        const CancelButton(),
        SizedBox(width: 5.w),
        MaterialButton(
          onPressed: () {
            context.read<CoachProvider>().callUnsetCoach(context, coach.id);
            Navigator.pop(context);
          },
          color: primaryColor,
          child: Text(
            AppLocalizations.of(context)!.coachProfilePopMenueUnassign,
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
      content: Text(
        AppLocalizations.of(context)!.unassignCoachConfirmation,
        style: MyDecorations.coachesTextStyle,
      ),
    );
  }
}
