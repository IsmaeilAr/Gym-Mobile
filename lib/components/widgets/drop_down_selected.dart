import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';

class MenuItem{
  final String text;
  final IconData icon;

  const MenuItem({required this.text, required this.icon});
}

class MenuItems{
  static const itemSelected=MenuItem(text: 'Select', icon: Icons.check_box);
  static const itemDesSelected=MenuItem(text: 'Deselect', icon: Icons.close);

  static const List<MenuItem> getMenuItems=[
    itemSelected,
    itemDesSelected
  ];
}

PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem<MenuItem>(

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

void onSelected(BuildContext context, MenuItem item) {
  switch (item) {
    case MenuItems.itemSelected:
      showDialog(
          context: context,
          builder: (context) => AlertDialogSelect());
        break;

    case MenuItems.itemDesSelected:
      showDialog(
          context: context,
          builder: (context) => AlertDialogDesSelect());
      break;
  }
}

 AlertDialogSelect() {
  return AlertDialog(
    backgroundColor: black,
    surfaceTintColor: black,
    elevation: 24.0,
    actions: [
      MaterialButton(
          onPressed: (){},
        child: Text("Cancel",
          style:MyDecorations.programsTextStyle,),
        color: black,
      ),
      SizedBox(width: 5.w),
      MaterialButton(
          onPressed: (){},
        child: Text("Set", style:MyDecorations.coachesTextStyle,),
        color: primaryColor,
      ),
    ],
    content: Text("Are you sure you want to set this program as your daily one?",
      style:MyDecorations.coachesTextStyle,),
  );

}

AlertDialogDesSelect() {
  return AlertDialog(
    backgroundColor: black,
    surfaceTintColor: black,
    elevation: 24.0,
    actions: [
      MaterialButton(
        onPressed: (){},
        child: Text("Cancel",
          style:MyDecorations.programsTextStyle,),
        color: black,
      ),
      SizedBox(width: 5.w),
      MaterialButton(
        onPressed: (){},
        child: Text("Deselect", style:MyDecorations.coachesTextStyle,),
        color: primaryColor,
      ),
    ],
    content: Text("Are you sure you want to deselect this program? It will not be your daily program once you deselect it.",
      style:MyDecorations.coachesTextStyle,),
  );
}


