import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/dialog/rate_coach_dialog.dart';
import 'package:gym/components/widgets/menu_item_model.dart';
import 'package:gym/features/profile/models/user_model.dart';
import '../dialog/cancel_button.dart';
import '../styles/colors.dart';
import '../styles/decorations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        const CancelButton(),
        SizedBox(width: 5.w),
        MaterialButton(
          onPressed: () {},
          color: primaryColor,
          child: Text(
            AppLocalizations.of(context)!.revoke,
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
      content: Text(
        AppLocalizations.of(context)!.revokeCoachRequestConfirmation,
        style: MyDecorations.coachesTextStyle,
      ),
    );
  }
}
