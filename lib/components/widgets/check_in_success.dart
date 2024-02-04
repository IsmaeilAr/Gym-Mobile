import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../styles/colors.dart';
import 'gap.dart';

class CheckInSuccess extends StatelessWidget {
  const CheckInSuccess({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SuccessLogo(),
        const Gap(
          h: 12,
        ),
        Text(
          "Check-In Success",
          style: TextStyle(
              color: lightGrey, fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
        Text(
          "welcome to the gym!",
          style: TextStyle(
              color: grey, fontWeight: FontWeight.w500, fontSize: 14.sp),
        ),
      ],
    );
  }
}
class SuccessLogo extends StatelessWidget {
  const SuccessLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/svg/success.svg',
      semanticsLabel: 'Success Logo',
      // height: 100,
      // width: 70,
    );
  }
}