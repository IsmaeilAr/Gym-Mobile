import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/widgets/loading_indicator.dart';
import 'package:gym/features/coaches/provider/coach_provider.dart';
import 'package:gym/features/coaches/screens/search_coaches_screen.dart';
import 'package:gym/features/profile/models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gym/features/profile/provider/profile_provider.dart';
import 'package:gym/features/profile/screens/coach_profile.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../components/widgets/back_button.dart';
import '../../../components/widgets/coach_tile_widget.dart';

class AllCoachesScreen extends StatefulWidget {
  const AllCoachesScreen({super.key});

  @override
  State<AllCoachesScreen> createState() => _AllCoachesScreenState();
}

class _AllCoachesScreenState extends State<AllCoachesScreen> {
  @override
  void initState() {
    context.read<CoachProvider>().getUsersList(context, "Coach");
    super.initState();
  }

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
            child: (context.watch<CoachProvider>().isLoadingGetUsers)
                ? const LoadingIndicatorWidget()
                : context.watch<CoachProvider>().coachList.isEmpty
                    ? Center(
                        child: Text('No coaches available',
                            style: MyDecorations.profileLight500TextStyle),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount:
                            context.watch<CoachProvider>().coachList.length,
                        itemBuilder: (context, index) {
                          UserModel coach =
                              context.watch<CoachProvider>().coachList[index];
                          bool isMyCoach = false;
                          if (context.read<ProfileProvider>().status.hasCoach) {
                            isMyCoach = coach.id ==
                                context
                                    .read<ProfileProvider>()
                                    .status
                                    .myCoach!
                                    .id;
                          }
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType
                                          .rightToLeftWithFade,
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
                                    child: CoachTileWidget(
                                        coach: coach, isMyCoach),
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
                      ),
          ),
        ],
      ),
    );
  }
}

class UsersAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final BuildContext context;

  const UsersAppBar({
    super.key,
    required this.title,
    required this.context,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: black,
      leading: const MyBackButton(),
      title: Text(
        title,
        style: const TextStyle(
          color: lightGrey,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        IconButton(
          color: lightGrey,
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    child: const SearchCoachesScreen()));
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}
