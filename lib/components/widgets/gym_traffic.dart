import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/gap.dart';
import 'package:provider/provider.dart';
import '../../features/home/provider/home_provider.dart';

class GymTraffic extends StatelessWidget {
  const GymTraffic({super.key});
  @override
  Widget build(BuildContext context) {
    bool busy = context.watch<HomeProvider>().isBusy;
    int peopleCount = context.watch<HomeProvider>().playersList.length;
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
                busy ?
                "assets/svg/red_dot.svg" :
                "assets/svg/green_dot.svg",  // todo make it dart code
                height: 28.w,
                width: 28.w,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8.w, 0, 0, 0),
                child: Gap(
                  w: 280,
                  h: 22,
                  child: Text(
                    'About $peopleCount people in the gym right now',
                    textAlign: TextAlign.start,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: busy ? red : green,
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
              busy ?
              'Gym\'s buzzing right now. Consider waiting for a more relaxing session!':
              "Gym's not full. Perfect time to jump in and claim your spot!",
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