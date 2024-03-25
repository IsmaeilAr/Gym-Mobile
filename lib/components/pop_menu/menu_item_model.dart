import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/colors.dart';

class MenuItemModel {
  final String text;
  final IconData icon;

  const MenuItemModel({required this.text, required this.icon});
}

// Function to build a PopupMenuItem for a given item
PopupMenuItem<MenuItemModel> buildItem(MenuItemModel item) =>
    PopupMenuItem<MenuItemModel>(
      value: item,
      child: Row(
        children: [
          Icon(item.icon, color: lightGrey, size: 12.sp),
          SizedBox(width: 7.w),
          Text(item.text, style: TextStyle(color: lightGrey, fontSize: 12.sp)),
        ],
      ),
    );
