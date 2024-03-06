import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/loading_indicator.dart';
import 'package:gym/components/widgets/programs_app_bar.dart';
import 'package:gym/features/coaches/provider/coach_provider.dart';
import 'package:gym/features/profile/models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gym/features/profile/provider/profile_provider.dart';
import 'package:gym/features/profile/screens/coach_profile.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../components/widgets/coach_tile_widget.dart';


class AllCoachesScreen extends StatefulWidget {
  const AllCoachesScreen({super.key});

  @override
  State<AllCoachesScreen> createState() => _AllCoachesScreenState();
}

class _AllCoachesScreenState extends State<AllCoachesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UsersAppBar(
        title: AppLocalizations.of(context)!.coaches,
        context: context,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<UserModel>>(
              future: context
                  .read<CoachProvider>()
                  .getCoachesList(context, "Coach"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingIndicatorWidget();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<UserModel> coaches = snapshot.data!;
                  if (coaches.isEmpty) {
                    return const Center(
                      child: Text('No coaches available'),
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: coaches.length,
                      itemBuilder: (context, index) {
                        UserModel coach = coaches[index];
                        bool isMyCoach = false;
                        if (context.read<ProfileProvider>().status.hasCoach) {
                          isMyCoach = coaches[index].id ==
                              context.read<ProfileProvider>().status.myCoach.id;
                        }
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: CoachProfileScreen(coach)));
                          },
                          child: Container(
                            height: 90.h,
                            width: 332.w,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 14.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: dark,
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16.h, horizontal: 16.w),
                                  child:
                                      CoachTileWidget(coach: coach, isMyCoach),
                                ),
                                // IconButton(
                                //   onPressed: () {},
                                //   icon: Icon(
                                //     Icons.more_horiz,
                                //     size: 19.sp,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

