import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';

class BarIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  const BarIconButton({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: lightGrey,
        size: 20.sp,
      ),
    );
  }
}
