import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/widgets/rate_coach.dart';

import '../styles/colors.dart';
import '../styles/decorations.dart';


final String coachFirstName="Noor";
double rate=1;

class MenuItemRevokeRequest{
  final String text;
  final IconData icon;

  const MenuItemRevokeRequest({required this.text, required this.icon});
}

class MenuItemsRevokeRequest{
  static const itemChangeCoach=MenuItemRevokeRequest(text: 'Revoke request', icon: Icons.close);
  static const itemRate=MenuItemRevokeRequest(text: 'Rate', icon: Icons.star);

  static const List<MenuItemRevokeRequest> getMenuItems=[
    itemChangeCoach,
    itemRate,
  ];
}

PopupMenuItem<MenuItemRevokeRequest> buildItemRevokeRequest(MenuItemRevokeRequest item) => PopupMenuItem<MenuItemRevokeRequest>(

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

void onSelectedRevokeRequest(BuildContext context, MenuItemRevokeRequest item) {
  switch (item) {
    case MenuItemsRevokeRequest.itemChangeCoach:
      showDialog(
          context: context,
          builder: (context) => RevokeRequest(coachFirstName: coachFirstName,));
      break;

    case MenuItemsRevokeRequest.itemRate:
      showDialog(
          context: context,
          builder: (context) => RateCoach(coachFirstName: coachFirstName,rate: rate));
      break;
  }
}


class RevokeRequest extends StatefulWidget {
  final String coachFirstName;
  const RevokeRequest({super.key, required this.coachFirstName});


  @override
  State<RevokeRequest> createState() => _RevokeRequestState();
}

class _RevokeRequestState extends State<RevokeRequest> {

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
        style: MyDecorations.coachesTextStyle,
      ),
    );
  }
}