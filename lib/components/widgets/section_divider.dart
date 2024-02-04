import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';


class SectionDivider extends StatelessWidget {
  final String text;
  const SectionDivider({super.key, required this.text, });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            color: lightGrey,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Divider(
            color: dark,
            thickness: 1.h,
          ),
        ),
      ],
    );
  }
}
