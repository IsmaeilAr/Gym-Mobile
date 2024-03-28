import 'package:flutter/material.dart';
import 'package:gym/components/dialog/rate_coach_dialog.dart';
import 'package:gym/components/pop_menu/menu_item_model.dart';
import 'package:gym/features/profile/models/user_model.dart';

import '../dialog/set_coach_dialog.dart';

void onSelectedSetCoach(
  BuildContext context,
  MenuItemModel item,
  UserModel coach,
  VoidCallback doSelectCoach,
  VoidCallback doRateCoach,
) {
  switch (item) {
    case Icons.check_box_outlined:
      showDialog(
        context: context,
        builder: (context) => SelectCoachDialog(
          doSelectCoach,
          coach: coach,
        ),
      );

      break;

    case Icons.star:
      showDialog(
          context: context,
          builder: (context) => RateStarsCoachDialog(
                coach: coach,
              ));
      break;
  }
}
