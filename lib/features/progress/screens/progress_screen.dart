import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/features/progress/models/monthly_model.dart';
import 'package:gym/features/progress/provider/progress_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../../components/styles/colors.dart';
import '../../../components/styles/decorations.dart';
import '../../../components/widgets/weekly_progress.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      _refresh();
    });
    super.initState();
  }
  Future<void> _refresh() async {
    context.read<ProgressProvider>().getMonthlyProgress(context);
  }


  @override
  Widget build(BuildContext context) {
    MonthlyProgressModel multiDateValue =
        context.watch<ProgressProvider>().monthProgress;
    double programProgress = context.watch<ProgressProvider>().programProgress;
    return Scaffold(
      body: RefreshIndicator(
        color: red,
        backgroundColor: dark,
        onRefresh: _refresh,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.w, bottom: 5.h),
                child: Text(
                  AppLocalizations.of(context)!.monthlyProgress,
                  style: TextStyle(
                      color: lightGrey,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              _buildDefaultMultiDatePickerWithValue(multiDateValue),
              SizedBox(height: 30.h),
              Text(
                AppLocalizations.of(context)!.weeklyProgress,
                style: TextStyle(
                    color: lightGrey,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height:7.h),
              const WeeklyProgressWidget(),
              Expanded(child: Divider(color: dark, thickness: 1.h,)),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.trainingProgramProgress,
                      style: TextStyle(
                          color: lightGrey,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 12.h),
                    CircularPercentIndicator(
                      backgroundColor: lightGrey,
                      radius: 70.r,
                      animation: true,
                      animationDuration: 1000,
                      lineWidth: 14.w,
                      percent: programProgress / 100,
                      //todo critical: request ?
                      progressColor: primaryColor,
                      circularStrokeCap: CircularStrokeCap.butt,
                      center: Text(
                        "$programProgress%",
                        style: TextStyle(
                            color: lightGrey,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



  Widget _buildDefaultMultiDatePickerWithValue(MonthlyProgressModel multiDateValue) {
    final today = DateUtils.dateOnly(DateTime.now());
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
        color: black,
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
            value: multiDateValue.dates,
          ),
        ),
      ),
    );
  }

