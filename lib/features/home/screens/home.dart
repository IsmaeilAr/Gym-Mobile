import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/gap.dart';
import 'package:gym/components/widgets/gym_traffic.dart';
import 'package:gym/utils/extensions/sizer.dart';

import '../../../components/widgets/countdown-page.dart';
import '../../../components/widgets/weekly_progress.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      // GymTraffic(),
      // const ScanButton(),
      Column(
        children: [
          CountdownWidget(),
          SuccessLogo(),
          Gap(h: 12,),
          Text("Check-In Success", style: TextStyle(color: lightGrey, fontWeight: FontWeight.w600, fontSize: 16.sp),),
          Text("welcome to the gym!", style: TextStyle(color: grey, fontWeight: FontWeight.w500, fontSize: 14.sp),),
        ],
      ),
      // Divider
      Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: const Divider(
          height: 1,
          color: dark,
        ),
      ),
      // daily card
      const DailyProgramCard(),
      // no training program screen
      const NoDailyPrograms(),

      // weekly progress
      WeeklyProgressWidget(),
    ]);
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

class ScanButton extends StatelessWidget {
  const ScanButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      child: InkWell(
          borderRadius: BorderRadius.circular(12.sp),
        onTap: () {},
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  Center(
                      child: SvgPicture.asset(
                        "assets/svg/QR_background.svg",
                        width: 328.w,
                        height: 112.h,
                      )),
                  Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 133.w, vertical: 12.h),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/scan_QR.svg",
                            width: 60.w,
                            height: 60.w,
                          ),
                          Text(
                            "Scan QR",
                            style: TextStyle(
                                color: lightGrey,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.sp), image: const DecorationImage(image: AssetImage("assets/images/daily_program.png"))),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Text("Daily Training Program", style: TextStyle(color: lightGrey, fontSize: 16.sp, fontWeight: FontWeight.w600),)),
      ),
    );
  }
}

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
            const Text(
                "No Daily Programs",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: grey
                )
            ),
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
            const Gap(h: 24,),
            SizedBox(
              width: 296.w,
              height: 46.h,
              child: ElevatedButton(
                onPressed: () {

                },
                style: MyDecorations.myButtonStyle(dark),
                child: Text(
                  'Set daily program',
                  style: MyDecorations.myButtonTextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

