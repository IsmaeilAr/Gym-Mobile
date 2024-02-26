import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/widgets/loading_indicator.dart';
import 'package:gym/features/coaches/provider/coach_provider.dart';
import 'package:gym/features/profile/models/user_model.dart';
import 'package:provider/provider.dart';

import '../../../components/styles/colors.dart';
import '../../../components/widgets/coach_tile_widget.dart';
import '../../../components/widgets/programs_app_bar.dart';

class SearchCoachesScreen extends StatefulWidget {
  const SearchCoachesScreen({super.key});

  @override
  State<SearchCoachesScreen> createState() => _SearchCoachesScreenState();
}

class _SearchCoachesScreenState extends State<SearchCoachesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CoachProvider>().searchCoachList = [];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<UserModel> coaches = context.read<CoachProvider>().searchCoachList;
    return Scaffold(
      appBar: SearchAppBar(
        hint: 'Search In Users',
        runFilter: () {
          doUserSearch(BuildContext, String);
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
                          child: CoachTileWidget(coach: coach),
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

  void doUserSearch(context, value) {
    context.read<CoachProvider>().searchUsers(context, value);
  }
}
