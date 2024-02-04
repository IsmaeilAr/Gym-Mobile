import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';

class DailyProgramCard extends StatelessWidget {
  const DailyProgramCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 332.w,
      height: 168.h,
      margin: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.sp),
          image: const DecorationImage(
              image: AssetImage("assets/images/daily_program.png"))),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Text(
              "Daily Training Program",
              style: TextStyle(
                  color: lightGrey,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
            )),
      ),
    );
  }
}
