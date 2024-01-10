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
    return CircleAvatar(
      radius: 16.r,
      backgroundColor: bgColor,
      child: Icon(
        icon,
        size: 20.r,
        color: lightGrey,
      ),
    );
  }
}
