import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    required this.icon,
    required this.bgColor,
  });
  final IconData icon;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: CircleAvatar(
        radius: 32.sp,
        backgroundColor: bgColor,
        child: Icon(
          icon,
          size: 10.sp,
          color: lightGrey,
        ),
      ),
    );
  }
}
