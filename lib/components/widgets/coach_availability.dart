import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/features/coaches/model/coach_time_model.dart';
import 'package:gym/features/coaches/provider/coach_provider.dart';
import 'package:provider/provider.dart';
import '../styles/colors.dart';
import 'gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CoachAvailabilityWidget extends StatelessWidget {
  const CoachAvailabilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(35.w, 12.h, 35.w, 25.h),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: context.watch<CoachProvider>().coachTimesList.length,
        scrollDirection: Axis.vertical,
        separatorBuilder: (BuildContext context, int index) {
          return const Gap(h: 12);
        },
        itemBuilder: (BuildContext context, int index) {
          List<CoachTimeModel> coachTimesList = context.watch<CoachProvider>().coachTimesList;
          return CoachDayWidget(
            index: index,
            day: coachTimesList[index],
          );
        },
      ),
    );
  }

}


class CoachDayWidget extends StatelessWidget {
  final CoachTimeModel day;
  final int index;

  const CoachDayWidget({super.key, required this.index, required this.day});

  @override
  Widget build(BuildContext context) {
    var translations = AppLocalizations.of(context)!;
    final List<String> weekDays = [
      translations.sat,
      translations.sun,
      translations.mon,
      translations.tue,
      translations.wed,
      translations.thu,
      translations.fri
    ];
    String dayName = weekDays[index];
    switch (day.isAvailable) {
      case false:
        return UnAvailableDay(dayName: dayName);
      case true:
        return AvailableDay(dayName: dayName, dayInfo: day);
      default:
        return const SizedBox();
    }
  }
}

class UnAvailableDay extends StatelessWidget {
  final String dayName;

  const UnAvailableDay({super.key, required this.dayName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: lightGrey,
          radius: 8.5.r,
          child: CircleAvatar(
            backgroundColor: black,
            radius: 7.5.r,
          ),
        ),
        const Gap(
          w: 8,
        ),
        Text(
          dayName,
          style: TextStyle(
            color: grey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class AvailableDay extends StatelessWidget {
  final String dayName;
  final CoachTimeModel dayInfo;

  const AvailableDay({super.key, required this.dayName, required this.dayInfo});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: lightGrey,
          radius: 9.r,
        ),
        const Gap(
          w: 8,
        ),
        SizedBox(
          width: 25.w,
          child: Text(
            dayName,
            style: TextStyle(
              color: lightGrey,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const Gap(
          w: 20,
        ),
        SizedBox(
          width: 140.w,
          child: Text(
            "${dayInfo.startTime} - ${dayInfo.endTime}",
            style: TextStyle(
              color: lightGrey,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }
}
