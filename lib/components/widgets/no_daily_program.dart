import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors.dart';
import '../styles/decorations.dart';
import 'gap.dart';

class NoDailyPrograms extends StatelessWidget {
  const NoDailyPrograms({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350.h,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("No Daily Programs",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w600, color: grey)),
            const Gap(h: 8),
            const Text(
              "You haven't selected a daily program yet. Set your training and nutrition programs in the 'Programs' section.",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: lightGrey,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(
              h: 24,
            ),
            SizedBox(
              width: 296.w,
              height: 46.h,
              child: ElevatedButton(
                onPressed: () {},
                style: MyDecorations.myButtonStyle(dark),
                child: Text(
                  'Set daily program',
                  style: MyDecorations.myButtonTextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}