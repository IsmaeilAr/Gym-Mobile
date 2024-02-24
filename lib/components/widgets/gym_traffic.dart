import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/gap.dart';
import 'package:provider/provider.dart';
import '../../features/home/provider/home_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 0),
                child: Gap(
                  w: 280,
                  h: 22,
                  child: Text(
                    '${AppLocalizations.of(context)!.homeGymTrafficPeopleInGym} $peopleCount ${AppLocalizations.of(context)!.homeGymTrafficPeopleInGym2}',
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
            padding: EdgeInsets.fromLTRB(36.w, 0, 36.w, 0),
            child: Text(
              busy
                  ? AppLocalizations.of(context)!.homeGymTrafficBusyGymMessage
                  : AppLocalizations.of(context)!
                      .homeGymTrafficNotFullGymMessage,
              textAlign: TextAlign.start,
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