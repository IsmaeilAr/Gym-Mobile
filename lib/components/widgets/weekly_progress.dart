import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gym/features/progress/provider/progress_provider.dart';
import 'package:provider/provider.dart';
import '../styles/colors.dart';
import 'gap.dart';

class WeeklyProgressWidget extends StatelessWidget {

  const WeeklyProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 51.h,
      width: 316.w,
      child: ListView.separated(
        itemCount: 7,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, int index) {
          return Gap(w: 20.w);
        },
        itemBuilder: (BuildContext context, int index) {
          List<int> doneDaysList =
              context.watch<ProgressProvider>().doneDaysList;
          return MyDayWidget(
            index: index,
            dayType: doneDaysList[index],
          );
        },
      ),
    );
  }

}


class MyDayWidget extends StatelessWidget {
  final int dayType;
  final int index;

  const MyDayWidget({super.key, required this.index, required this.dayType});

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

    switch (dayType) {
      case 0:
        return UnDoneDay(dayName: dayName);
      case 1:
        return DoneDay(dayName: dayName);
      case 2:
        return CurrentDay(dayName: dayName);
      default:
        return UnDoneDay(dayName: dayName);
    }
  }
}

class CurrentDay extends StatelessWidget {
  final String dayName;

  const CurrentDay({super.key, required this.dayName});

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
          dayName,
          style: TextStyle(
            color: lightGrey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class UnDoneDay extends StatelessWidget {
  final String dayName;

  const UnDoneDay({super.key, required this.dayName});

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

class DoneDay extends StatelessWidget {
  final String dayName;

  const DoneDay({super.key, required this.dayName});

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
          dayName,
          style: TextStyle(
            color: lightGrey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
