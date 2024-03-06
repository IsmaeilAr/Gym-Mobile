import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';
import '../styles/decorations.dart';

class SectionDivider extends StatelessWidget {
  final String text;
  const SectionDivider({super.key, required this.text, });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: MyDecorations.calendarTextStyle,
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
