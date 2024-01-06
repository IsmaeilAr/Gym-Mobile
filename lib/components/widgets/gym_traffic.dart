import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/gap.dart';

class GymTraffic extends StatelessWidget {
  const GymTraffic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0,8.h,0,18.h),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/svg/red_dot.svg",
                height: 28.w,
                width: 28.w,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8.w, 0, 0, 0),
                child: Gap(
                  w: 280,
                  h: 22,
                  child: Text(
                    'About 20 people in the gym right now',
                    textAlign: TextAlign.start,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: red,
                      height: 1.6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(36.w, 0, 0, 0),
            child: Text(
              'Gym\'s buzzing right now. Consider waiting for a more relaxing session!',
              textAlign: TextAlign.left,
              softWrap: true,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: lightGrey,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}