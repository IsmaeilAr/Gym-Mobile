import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/widgets/rate_coach.dart';

import '../styles/colors.dart';
import '../styles/decorations.dart';


final String coachFirstName="Noor";
double rate=1;
bool AcceptedRequest=true;

class MenuItemSetCoach{
  final String text;
  final IconData icon;

  const MenuItemSetCoach({required this.text, required this.icon});
}

class MenuItemsSetCoach{
  static const itemChangeCoach=MenuItemSetCoach(text: 'Set coach', icon: Icons.check_box_outlined);
  static const itemRate=MenuItemSetCoach(text: 'Rate', icon: Icons.star);

  static const List<MenuItemSetCoach> getMenuItems=[
    itemChangeCoach,
    itemRate,
  ];
}

PopupMenuItem<MenuItemSetCoach> buildItemSetCoach(MenuItemSetCoach item) => PopupMenuItem<MenuItemSetCoach>(

  value: item,
  child: Row(
    children: [
      Icon(item.icon, color: Colors.white, size: 12.sp),
      SizedBox(width: 7.w),
      Text(item.text,
          style: TextStyle(color: Colors.white, fontSize: 12.sp)),
    ],
  ),
);


void onSelectedSetCoach(BuildContext context, MenuItemSetCoach item) {
  switch (item) {
    case MenuItemsSetCoach.itemChangeCoach:

        showDialog( 
          context: context,
          builder:  (context) =>SetCoach(),
          //useRootNavigator: true,
        );


      break;


    case MenuItemsSetCoach.itemRate:
      showDialog(
          context: context,
          builder: (context) => RateCoach(coachFirstName: coachFirstName,rate: rate,));
      break;
  }
}

class SetCoach extends StatefulWidget {
  const SetCoach({super.key});

  @override
  State<SetCoach> createState() => _SetCoachState();
}

class _SetCoachState extends State<SetCoach> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
    );
  }
}
