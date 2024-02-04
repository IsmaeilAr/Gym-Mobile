import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/check_in_success.dart';
import 'package:gym/components/widgets/gym_traffic.dart';
import 'package:gym/features/home/provider/home_provider.dart';
import 'package:gym/features/profile/provider/profile_provider.dart';
import 'package:gym/features/progress/provider/progress_provider.dart';
import 'package:provider/provider.dart';
import '../../../components/widgets/countdown.dart';
import '../../../components/widgets/daily_program_card.dart';
import '../../../components/widgets/loading_indicator.dart';
import '../../../components/widgets/no_daily_program.dart';
import '../../../components/widgets/qr_scan_button.dart';
import '../../../components/widgets/weekly_progress.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<HomeProvider>().getActivePlayersApi(context,);
      context.read<ProgressProvider>().getWeeklyProgressApi(context,);
      context.read<ProfileProvider>().getStatus(context,);
    });
    super.initState();
  }
  Future<void> _refresh() async {
    context.read<HomeProvider>().getActivePlayersApi(context,);
    context.read<ProgressProvider>().getWeeklyProgressApi(context,);
    context.read<ProfileProvider>().getStatus(context,);
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: red,
        backgroundColor: dark,
        onRefresh: _refresh,
      child:
      !context.watch<ProfileProvider>().isLoadingStatus &&
      !context.watch<HomeProvider>().isLoadingActivePlayers &&
      !context.watch<ProgressProvider>().isLoadingWeeklyProgress
          ?
      Container(
        padding: EdgeInsets.all(14.w),
        child: ListView(children: [
          SizedBox(
            height: 228.h,
            child:
            context.watch<HomeProvider>().showCheckInSuccess ?
                const CheckInSuccess() :
            context.watch<HomeProvider>().isCheckIn ?
            const CountdownWidget() :
            const Column(
              children: [
                GymTraffic(),
                ScanButton(),
              ],
            ),
          ),
          // Divider
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: const Divider(
              height: 1,
              color: dark,
            ),
          ),

          context.watch<ProfileProvider>().hasProgram ?
          // daily card
          const DailyProgramCard() :
          // no training program screen
          const NoDailyPrograms(),
          // weekly progress
          const Center(
              child:
              WeeklyProgressWidget()
          ),
        ]),
      ) :
      const LoadingIndicatorWidget()
    );
  }

}

