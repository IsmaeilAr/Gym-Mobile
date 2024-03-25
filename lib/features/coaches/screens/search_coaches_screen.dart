import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/widgets/loading_indicator.dart';
import 'package:gym/features/coaches/provider/coach_provider.dart';
import 'package:gym/features/profile/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../components/styles/colors.dart';
import '../../../components/widgets/coach_tile_widget.dart';
import '../../../components/widgets/search_app_bar.dart';
import '../../profile/provider/profile_provider.dart';

class SearchCoachesScreen extends StatelessWidget {
  const SearchCoachesScreen({super.key});


  @override
  Widget build(BuildContext context) {
    List<UserModel> coaches = context.watch<CoachProvider>().searchCoachList;
    return Scaffold(
      appBar: SearchAppBar(
        hint: AppLocalizations.of(context)!.searchInUsers,
        searchFun: (value) {
          context.read<CoachProvider>().searchUsers(context, value);
        },
      ),
      body: context.watch<CoachProvider>().isLoadingSearchCoach
          ? const LoadingIndicatorWidget()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: coaches.length,
                    itemBuilder: (context, index) {
                      UserModel coach = coaches[index];
                      bool isMyCoach = false;
                      if (context.read<ProfileProvider>().status.hasCoach) {
                        isMyCoach = coaches[index].id ==
                            context.read<ProfileProvider>().status.myCoach!.id;
                      }
                      return Container(
                          height: 90.h,
                          width: 332.w,
                          margin:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.w),
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
                                child: CoachTileWidget(
                                  isMyCoach,
                                  coach: coach,
                                ),
                              ),
                              IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.more_horiz,
                              size: 19.sp,
                            )),
                      ],
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
