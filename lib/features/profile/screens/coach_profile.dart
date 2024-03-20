import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/pop_menu/pop_menu_change_coach.dart';
import 'package:gym/components/pop_menu/pop_menu_revoke_request.dart';
import 'package:gym/components/pop_menu/pop_menu_set_coach.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/styles/decorations.dart';
import 'package:gym/components/styles/gym_icons.dart';
import 'package:gym/components/widgets/back_button.dart';
import 'package:gym/components/widgets/coach_availability.dart';
import 'package:gym/components/widgets/loading_indicator.dart';
import 'package:gym/components/widgets/net_image.dart';
import 'package:gym/components/widgets/menu_item_model.dart';
import 'package:gym/features/articles/screens/coach_articles_screen.dart';
import 'package:gym/features/chat/screens/chat_screen.dart';
import 'package:gym/features/coaches/provider/coach_provider.dart';
import 'package:gym/features/profile/models/user_model.dart';
import 'package:gym/features/profile/provider/profile_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../components/dialog/cancel_button.dart';
import '../../../components/dialog/set_coach_dialog.dart';

int popupMenuCase = 2; // 1_ChangeCoach  2_SetCoach  3_RevokeRequest // todo

class CoachProfileScreen extends StatefulWidget {
  final UserModel coach;

  const CoachProfileScreen(this.coach, {super.key});

  @override
  State<CoachProfileScreen> createState() => _CoachProfileScreenState();
}

class _CoachProfileScreenState extends State<CoachProfileScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  bool isSelectedCoach = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refresh();
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    isSelectedCoach =
        context.read<ProfileProvider>().status.myCoach.id == widget.coach.id;
    context.read<CoachProvider>().getCoachTime(context, widget.coach.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CoachesProfileAppBar(
        popupMenuCase: 1,
        onSelectedSetCoachFun: (context, getSetMenuItems) {},
        onSelectedRevokeRequestFun: (context, getRevokeMenuItems) {},
        onSelectedChangeCoachFun: (context, getChangeMenuItems) {},
        coach: widget.coach,
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: black,
            child: TabBar.secondary(
              controller: _tabController,
              unselectedLabelColor: grey,
              labelStyle: const TextStyle(color: primaryColor),
              indicatorColor: primaryColor,
              dividerColor: black,
              tabs: <Widget>[
                Tab(text: AppLocalizations.of(context)!.coachProfileInfo),
                Tab(text: AppLocalizations.of(context)!.coachProfileArticles),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                RefreshIndicator(
                    color: red,
                    backgroundColor: dark,
                    onRefresh: _refresh,
                    child: CoachInfoTab(widget.coach, isSelectedCoach)),
                RefreshIndicator(
                    color: red,
                    backgroundColor: dark,
                    onRefresh: _refresh,
                    child: CoachArticlesList(widget.coach.id)),
                // todo parameter
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeftWithFade,
                  child: ChatScreen(widget.coach.id, widget.coach.name)));
        },
        backgroundColor: dark,
        child: Icon(
          GymIcons.chat,
          size: 20.sp,
          color: lightGrey,
        ),
      ),
    );
  }
}

class CoachInfoTab extends StatelessWidget {
  final UserModel coach;
  final bool isSelectedCoach;

  const CoachInfoTab(this.coach, this.isSelectedCoach, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 6.h,
        horizontal: 9.w,
      ),
      child: SizedBox(
        width: 360.w,
        height: 731.h,
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CoachImage(coach, isSelectedCoach),
            InfoWithIconWidget(
                icon: Icons.phone,
                info: AppLocalizations.of(context)!.coachProfilePhone),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 19.w),
              child: Text(
                coach.phoneNumber,
                style: MyDecorations.profileLight400TextStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: InfoWithIconWidget(
                  icon: Icons.error,
                  info: AppLocalizations.of(context)!.coachProfileBio),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 19.w),
              child: Text(
                (coach.description.isEmpty)
                    ? 'not set yet..'
                    : coach.description,
                style: MyDecorations.profileLight400TextStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: InfoWithIconWidget(
                  icon: GymIcons.stopwatchFilled,
                  info: AppLocalizations.of(context)!.coachProfileAvailability),
            ),
            context.watch<CoachProvider>().isLoadingCoachTime
                ? const LoadingIndicatorWidget()
                : const CoachAvailabilityWidget()
          ],
        ),
      ),
    );
  }
}

class InfoWithIconWidget extends StatelessWidget {
  final IconData icon;
  final String info;

  const InfoWithIconWidget({super.key, required this.icon, required this.info});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: lightGrey,
          size: 15.sp,
        ),
        SizedBox(width: 6.w),
        Text(
          info,
          style: MyDecorations.calendarTextStyle,
        ),
      ],
    );
  }
}

class ChangeCoach extends StatefulWidget {
  final String name;
  final int coachId;

  const ChangeCoach({super.key, required this.name, required this.coachId});

  @override
  State<ChangeCoach> createState() => _ChangeCoachState();
}

class _ChangeCoachState extends State<ChangeCoach> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: black,
      surfaceTintColor: black,
      actions: [
        const CancelButton(),
        SizedBox(width: 5.w),
        MaterialButton(
          onPressed: () {
            context.read<CoachProvider>().setCoach(context, widget.coachId);
          },
          color: primaryColor,
          child: Text(
            AppLocalizations.of(context)!.change,
            style: MyDecorations.coachesTextStyle,
          ),
        ),
      ],
      content: Text(
        "${AppLocalizations.of(context)!.coachProfileChangeCoachConfirmation} ${widget.name} ${AppLocalizations.of(context)!.coachProfileChangeCoachConfirmation2}",
        style: MyDecorations.coachesTextStyle,
      ),
    );
  }
}

class CoachesProfileAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final int popupMenuCase;
  final Function(BuildContext, MenuItemModel) onSelectedChangeCoachFun;
  final Function(BuildContext, MenuItemModel) onSelectedSetCoachFun;
  final Function(BuildContext, MenuItemModel) onSelectedRevokeRequestFun;
  final UserModel coach;

  const CoachesProfileAppBar({
    super.key,
    required this.popupMenuCase,
    required this.onSelectedSetCoachFun,
    required this.onSelectedRevokeRequestFun,
    required this.onSelectedChangeCoachFun,
    required this.coach,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: black,
      leading: const MyBackButton(),
      title: Text(
        AppLocalizations.of(context)!.mainLayoutAppBarProfileScreenName,
        style: TextStyle(
          color: lightGrey,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        CustomPopupMenuButton(popupMenuCase, coach),
      ],
    );
  }
}

class CustomPopupMenuButton extends StatelessWidget {
  final int popupMenuCases;
  final UserModel coach;

  const CustomPopupMenuButton(this.popupMenuCases, this.coach, {super.key});

  @override
  Widget build(BuildContext context) {
    switch (popupMenuCase) {
      case 1:
        return PopupMenuButton<MenuItemModel>(
          itemBuilder: (context) => [
            ...ChangeCoachMenuItems.getChangeMenuItems.map(buildItem),
          ],
          onSelected: (item) => onSelectedChangeCoach(
            context,
            item,
            coach,
          ),
          color: black,
          iconColor: lightGrey,
          icon: const Icon(Icons.more_horiz_sharp, size: 20),
        );
      case 2:
        return PopupMenuButton<MenuItemModel>(
          itemBuilder: (context) => [
            ...SetCoachMenuItems.getSetMenuItems.map(buildItem),
          ],
          onSelected: (item) => onSelectedSetCoach(context, item, coach, () {
            _doSelectCoach(context, coach.id);
          }, () {
            _doUnselectCoach(context, coach.id);
          }),
          color: dark,
          iconColor: lightGrey,
          icon: const Icon(Icons.more_horiz_sharp, size: 20),
        );
      case 3:
        return PopupMenuButton<MenuItemModel>(
          itemBuilder: (context) => [
            ...RevokeRequestMenuItems.getRevokeMenuItems.map(buildItem),
          ],
          onSelected: (item) => onSelectedRevokeRequest(context, item, coach),
          color: black,
          iconColor: lightGrey,
          icon: const Icon(Icons.more_horiz_sharp, size: 20),
        );
      default:
        return Container();
    }
  }

  void _doSelectCoach(
    BuildContext context,
    int coachId,
  ) {
    context.read<CoachProvider>().setCoach(context, coach.id);
    // todo onRefresh
  }

  void _doUnselectCoach(BuildContext context, int coachId) {
    context.read<CoachProvider>().callUnsetCoach(context, coachId);
    // todo onRefresh
  }
}

class CoachImage extends StatelessWidget {
  final UserModel coach;
  final bool isSelectedCoach;

  const CoachImage(this.coach, this.isSelectedCoach, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
              radius: 90.r,
              backgroundImage: networkImage(
                coach,
              )),
          Text(
            coach.name,
            style: TextStyle(
              color: lightGrey,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          RatingBarIndicator(
            rating: coach.rate,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: red,
            ),
            itemCount: 5,
            itemSize: 10.sp,
            direction: Axis.horizontal,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: isSelectedCoach
                ? ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 10.h),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.coachProfileSelected,
                      style: TextStyle(
                        color: lightGrey,
                        fontFamily: "Saira",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.0,
                      ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => SelectCoachDialog(
                                () {
                                  _doSelectCoach(context, coach.id);
                                },
                                coach: coach,
                              ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: dark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 10.h),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.coachProfileSetCoach,
                      style: TextStyle(
                        color: lightGrey,
                        fontFamily: "Saira",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.0,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void _doSelectCoach(
    BuildContext context,
    int coachId,
  ) {
    context.read<CoachProvider>().setCoach(context, coach.id);
    // todo onRefresh
  }
}
