import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/colors.dart';
import '../styles/decorations.dart';

class MonthlyProgressWidget extends StatelessWidget {
  final DateTime today;
  final List<DateTime> multiDatePickerValue;

  const MonthlyProgressWidget({super.key,
    required this.today,
    required this.multiDatePickerValue,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime firstDate = DateTime(today.year, today.month, 1);
    final DateTime lastDate = DateTime(today.year, today.month + 1, 0);

    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.multi,
      selectedDayHighlightColor: lightGrey,
      centerAlignModePicker: true,
      firstDate: firstDate,
      lastDate: lastDate,
      disableModePicker: true,
      selectableDayPredicate: (day) => (day == today),
      controlsTextStyle: MyDecorations.calendarTextStyle,
      selectedDayTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
      selectedYearTextStyle: MyDecorations.calendarTextStyle,
      dayTextStyle: MyDecorations.calendarTextStyle,
      yearTextStyle: MyDecorations.calendarTextStyle,
      todayTextStyle: MyDecorations.calendarTextStyle,
      weekdayLabelTextStyle: TextStyle(
        color: grey,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        fontFamily: 'Saira',
      ),
      disabledDayTextStyle: MyDecorations.calendarTextStyle,
      nextMonthIcon: Icon(
        Icons.arrow_forward_ios,
        size: 15.sp,
        color: lightGrey,
      ),
      lastMonthIcon: Icon(
        Icons.arrow_back_ios,
        size: 15.sp,
        color: lightGrey,
      ),
    );

    return Center(
      child: SizedBox(
        height: 295.h,
        width: 332.w,
        child: Card(
          color: dark,
          child: CalendarDatePicker2(
            config: config,
            value: multiDatePickerValue,
          ),
        ),
      ),
    );
  }
}
