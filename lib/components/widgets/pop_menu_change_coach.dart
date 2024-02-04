import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/widgets/rate_coach.dart';
import '../styles/colors.dart';
import '../styles/decorations.dart';


final String coachFirstName="Noor";
double rate=1;


class MenuItemChangeCoach{
  final String text;
  final IconData icon;

  const MenuItemChangeCoach({required this.text, required this.icon});
}

class MenuItemsChangeCoach{
  static const itemChangeCoach=MenuItemChangeCoach(text: 'Change coach', icon: Icons.create);
  static const itemUnassign=MenuItemChangeCoach(text: 'Unassign', icon: Icons.close);
  static const itemRate=MenuItemChangeCoach(text: 'Rate', icon: Icons.star);

  static const List<MenuItemChangeCoach> getMenuItems=[
    itemChangeCoach,
    itemUnassign,
    itemRate,
  ];
}

PopupMenuItem<MenuItemChangeCoach> buildItemChangeCoach(MenuItemChangeCoach item) => PopupMenuItem<MenuItemChangeCoach>(

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


void onSelectedChangeCoach(BuildContext context, MenuItemChangeCoach item) {
  switch (item) {
    case MenuItemsChangeCoach.itemChangeCoach:
      showDialog(
          context: context,
          builder: (context) => ChangeCoach(coachFirstName: coachFirstName,));
      break;

    case MenuItemsChangeCoach.itemUnassign:
      showDialog(
          context: context,
          builder: (context) => UnassignCoach());
      break;

      case MenuItemsChangeCoach.itemRate:
      showDialog(
          context: context,
          builder: (context) => RateCoach(coachFirstName: coachFirstName,rate: rate));
      break;
  }
}

class ChangeCoach extends StatefulWidget {
  final String coachFirstName;
  const ChangeCoach({super.key, required this.coachFirstName});


  @override
  State<ChangeCoach> createState() => _ChangeCoachState();
}

class _ChangeCoachState extends State<ChangeCoach> {

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
            "Change",
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
      content: Text(
        "Are you sure you want to change your current coach to ${widget.coachFirstName} as your new coach?",
        style: MyDecorations.coachesTextStyle,
      ),
    );
  }
}

class UnassignCoach extends StatefulWidget {
  const UnassignCoach({super.key});

  @override
  State<UnassignCoach> createState() => _UnassignCoachState();
}

class _UnassignCoachState extends State<UnassignCoach> {

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


