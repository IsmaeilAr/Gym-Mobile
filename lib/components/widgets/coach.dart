import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/features/coaches/screens/all_coaches_screen.dart';
import 'package:gym/features/profile/models/user_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../features/coaches/provider/coach_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../features/profile/screens/coach_profile.dart';
import '../pop_menu/pop_menu_change_coach.dart';
import 'find_coach_button.dart';
import '../pop_menu/menu_item_model.dart';
import 'net_image.dart';

class NoCoachScreen extends StatelessWidget {
  const NoCoachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: grey,
              child: Icon(
                Icons.person,
                size: 20.r,
                color: lightGrey,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
                child: Text(
              AppLocalizations.of(context)!.myProfileNoCoachMessage,
              style: MyDecorations.profileLight500TextStyle,
            )),
          ],
        ),
        SizedBox(height: 10.h),
        const FindCoachButton(),
      ],
    );
  }
}

class MyCoachWidget extends StatelessWidget {
  final UserModel coach;

  const MyCoachWidget(
    this.coach, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    child: CoachProfileScreen(coach)));
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: networkImage(
                  coach,
                ),
                radius: 20.r,
              ),
              SizedBox(width: 10.w),
              Text(coach.name, style: MyDecorations.profileLight500TextStyle),
            ],
          ),
        ),
        PopupMenuButton<MenuItemModel>(
          itemBuilder: (context) => [
            ...ChangeCoachMenuItems.getChangeMenuItems.map(buildItem),
          ],
          onSelected: (item) => onSelectedChangeCoach(
            context,
            item,
            coach,
          ),
          color: black,
          child: Padding(
            padding: EdgeInsets.all(8.h),
            child: const Icon(
              Icons.more_horiz_sharp,
              size: 20,
              color: lightGrey,
            ),
          ),
        ),
      ],
    );
  }
}
