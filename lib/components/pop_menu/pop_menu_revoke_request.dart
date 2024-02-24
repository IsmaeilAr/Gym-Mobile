import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/dialog/rate_coach_dialog.dart';
import 'package:gym/components/widgets/menu_item_model.dart';
import 'package:gym/features/profile/models/user_model.dart';
import '../styles/colors.dart';
import '../styles/decorations.dart';

class RevokeRequestMenuItems {
  static const MenuItemModel itemChangeCoach =
      MenuItemModel(text: "Revoke request", icon: Icons.close);
  static const itemRate = MenuItemModel(text: 'Rate', icon: Icons.star);

  static List<MenuItemModel> getRevokeMenuItems = [
    itemChangeCoach,
    itemRate,
  ];
}

void onSelectedRevokeRequest(
    BuildContext context, MenuItemModel item, UserModel coach) {
  switch (item) {
    case RevokeRequestMenuItems.itemChangeCoach:
      showDialog(
          context: context,
          builder: (context) => RevokeRequest(
                coach: coach,
              ));
      break;

    case RevokeRequestMenuItems.itemRate:
      showDialog(
          context: context,
          builder: (context) => RateStarsCoachDialog(
                coach: coach,
              )); // todo fix
      break;
  }
}

class RevokeRequest extends StatelessWidget {
  final UserModel coach;

  const RevokeRequest({super.key, required this.coach});

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
            "Revoke",
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
      content: Text(
        "Are you sure you want to revoke your request for a selected coach?",
        //todo localize
        style: MyDecorations.coachesTextStyle,
      ),
    );
  }
}
