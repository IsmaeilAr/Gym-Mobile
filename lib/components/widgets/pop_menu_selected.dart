import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';

import 'dialog_widget.dart';

class MenuItemModel{
  final String text;
  final IconData icon;

  const MenuItemModel({required this.text, required this.icon});
}

class MenuItems{
  static const itemSelected=MenuItemModel(text: 'Select', icon: Icons.check_box);
  static const itemDesSelected=MenuItemModel(text: 'Deselect', icon: Icons.close);

  static const List<MenuItemModel> getMenuItems=[
    itemSelected,
    itemDesSelected
  ];
}

PopupMenuItem<MenuItemModel> buildItem(MenuItemModel item) => PopupMenuItem<MenuItemModel>(

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

void onSelected(BuildContext context, MenuItemModel item, VoidCallback onConfirm) {
  switch (item) {
    case MenuItems.itemSelected:
      showDialog(
          context: context,
          builder: (context) => AlertDialogSelect(onConfirm: onConfirm));
        break;

    case MenuItems.itemDesSelected:
      showDialog(
          context: context,
          builder: (context) => AlertDialogUnSelect(onConfirm: onConfirm));
      break;
  }
}




