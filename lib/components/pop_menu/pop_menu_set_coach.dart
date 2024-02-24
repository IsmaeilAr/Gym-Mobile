import 'package:flutter/material.dart';
import 'package:gym/components/dialog/rate_coach_dialog.dart';
import 'package:gym/components/widgets/menuItem_model.dart';
import 'package:gym/features/profile/models/user_model.dart';

import '../dialog/set_coach_dialog.dart';

class SetCoachMenuItems {
  static const itemChangeCoach =
      MenuItemModel(text: 'Set coach', icon: Icons.check_box_outlined);
  static const itemRate = MenuItemModel(text: 'Rate', icon: Icons.star);

  static const List<MenuItemModel> getSetMenuItems = [
    itemChangeCoach,
    itemRate,
  ];
}

void onSelectedSetCoach(
  BuildContext context,
  MenuItemModel item,
  UserModel coach,
  VoidCallback doSelectCoach,
  VoidCallback doRateCoach,
) {
  switch (item) {
    case SetCoachMenuItems.itemChangeCoach:
      showDialog(
        context: context,
        builder: (context) => SelectCoachDialog(
          doSelectCoach,
          coach: coach,
        ), // todo make dialog
        //useRootNavigator: true,
      );

      break;

    case SetCoachMenuItems.itemRate:
      showDialog(
          context: context,
          builder: (context) => RateStarsCoachDialog(
                coach: coach,
              ));
      break;
  }
}
