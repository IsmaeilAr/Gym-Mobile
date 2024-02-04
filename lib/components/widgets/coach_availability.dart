import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/features/coaches/model/coach_time_model.dart';
import 'package:gym/features/coaches/provider/coach_provider.dart';
import 'package:gym/features/profile/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import '../styles/colors.dart';
import 'gap.dart';

class CoachAvailabilityWidget extends StatelessWidget {
  const CoachAvailabilityWidget({super.key});



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 51.h,
      width: 316.w,
      child: ListView.separated(
        itemCount: 7,
        scrollDirection: Axis.vertical,
        separatorBuilder: (BuildContext context, int index) {
          return const Gap(h: 12);
        },
        itemBuilder: (BuildContext context, int index) {
          List<CoachTimeModel> coachTimesList = context.watch<CoachProvider>().coachTimesList;
          // List<int> doneDaysList = context.watch<ProfileProvider>().coachTimesList;
          return CoachDayWidget(index: index, dayType: coachTimesList[index].dayId,);
        },
      ),
    );
  }

}


class CoachDayWidget extends StatelessWidget {
  final int dayType;
  final int index;
  final List<String> weekDays = [ "Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri"];

  CoachDayWidget({super.key, required this.index, required this.dayType});

  @override
  Widget build(BuildContext context) {
    String dayName = weekDays[index];

    switch (dayType) {
      case 0:
        return UnAvailableDay(dayName: dayName);
      case 1:
        return AvailableDay(dayName: dayName);
      default:
        return UnAvailableDay(dayName: dayName);
    }
  }
}

class UnAvailableDay extends StatelessWidget {
  final String dayName;

  const UnAvailableDay({super.key, required this.dayName});

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

class AvailableDay extends StatelessWidget {
  final String dayName;

  const AvailableDay({super.key, required this.dayName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: lightGrey,
          radius: 14.r,
        ),
        const Gap(
          w: 8,
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
