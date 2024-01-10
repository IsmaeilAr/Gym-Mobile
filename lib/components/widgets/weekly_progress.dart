import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/widgets/gap.dart';

import '../styles/colors.dart';

class WeeklyProgressWidget extends StatelessWidget {
  const WeeklyProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 51.h,
      width: 316.w,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DoneDay(),
          UnDoneDay(),
          CurrentDay(),
        ],
      ),
    );
  }
}

class CurrentDay extends StatelessWidget {
  const CurrentDay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: lightGrey,
          radius: 14.r,
          child: CircleAvatar(
            backgroundColor: black,
            radius: 13.r,
            child: CircleAvatar(
              backgroundColor: lightGrey,
              radius: 4.r,
            ),
          ),
        ),
        const Gap(
          h: 4,
        ),
        Text(
          "Mon",
          style: TextStyle(
              color: grey,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}

class UnDoneDay extends StatelessWidget {
  const UnDoneDay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: lightGrey,
          radius: 14.r,
          child: CircleAvatar(
            backgroundColor: black,
            radius: 13.r,
          ),
        ),
        const Gap(
          h: 4,
        ),
        Text(
          "Sun",
          style: TextStyle(
              color: grey,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}

class DoneDay extends StatelessWidget {
  const DoneDay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: lightGrey,
          radius: 14.r,
        ),
        const Gap(
          h: 4,
        ),
        Text(
          "Sat",
          style: TextStyle(
              color: lightGrey,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
