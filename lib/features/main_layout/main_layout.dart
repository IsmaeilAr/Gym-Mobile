import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/icon_button.dart';
import 'package:gym/components/widgets/snack_bar.dart';
import 'package:gym/features/chat/screens/chat_list_screen.dart';
import 'package:gym/features/drawer/drawer_widget.dart';
import 'package:gym/features/home/screens/home.dart';
import 'package:gym/features/main_layout/main_layout_provider.dart';
import 'package:gym/features/notifications/screens/notifications_screen.dart';
import 'package:gym/features/profile/screens/my_profile.dart';
import 'package:gym/features/progress/screens/progress_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../components/styles/gym_icons.dart';
import '../articles/screens/articles_screen.dart';
import '../programs/screens/programs_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainLayout extends StatelessWidget {
  MainLayout({super.key});

  final pageIconList = <IconData>[
    GymIcons.home,
    GymIcons.programs,
    GymIcons.progress,
    GymIcons.profile,
  ];

  final screens = <Widget>[
    const HomePage(),
    const ProgramsScreen(),
    const ProgressScreen(),
    const MyProfile(),
  ];
  bool isClear = false;
  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    final selectedIndexProvider =
        context.watch<MainLayoutProvider>().selectedIndex;

    final List<String> screenNames = [
      AppLocalizations.of(context)!.mainLayoutAppBarHomeScreenName,
      AppLocalizations.of(context)!.mainLayoutAppBarProgramsScreenName,
      AppLocalizations.of(context)!.mainLayoutAppBarProgressScreenName,
      AppLocalizations.of(context)!.mainLayoutAppBarProfileScreenName,
    ];
    return PopScope(
      canPop: isClear,
      onPopInvoked: (didPop) {
        _onPop();
      },
      child: Scaffold(
        appBar: MainAppBar(
          title: screenNames[selectedIndexProvider],
        ),
        body: Container(
            // padding: EdgeInsets.all(14.w),
            child: screens[selectedIndexProvider]),
        drawer: const MyDrawer(),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 47.w,
          ),
          child: GNav(
            backgroundColor: black,
            hoverColor: red,
            activeColor: red,
            iconSize: 24.dm,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            duration: const Duration(milliseconds: 400),
            tabs: [
              GButton(
                icon: pageIconList[0],
                iconColor: grey,
              ),
              GButton(
                icon: pageIconList[1],
                iconColor: grey,
              ),
              GButton(
                icon: pageIconList[2],
                iconColor: grey,
                iconSize: 20.sp,
              ),
              GButton(
                icon: pageIconList[3],
                iconColor: grey,
              ),
            ],
            selectedIndex: selectedIndexProvider,
            onTabChange: (index) {
              context.read<MainLayoutProvider>().selectedIndex = index;
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onPop() async {
    DateTime now = DateTime.now();
    if (_lastPressedAt == null ||
        now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
      _lastPressedAt = now;
      showMessage('press again to exit', true);
      isClear = false;
    }
    isClear = true;
  }
}

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.title,
  });
  @override
  Size get preferredSize => Size.fromHeight(52.h);

  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: black,
      leading: BarIconButton(
        icon: Icons.menu,
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      title: Text(
        title,
        style: TextStyle(
            color: lightGrey, fontSize: 20.sp, fontWeight: FontWeight.w700),
      ),
      actions: [
        BarIconButton(
          icon: GymIcons.notification,
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    child: const NotificationsScreen(
                    )
                ));
          },
        ),
        BarIconButton(
          icon: GymIcons.article,
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    child: const ArticlesScreens(
                    )
                ));
          },
        ),
        BarIconButton(
          icon: GymIcons.chat,
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    child: const ChatListScreen(
                    )
                ));
          },
        ),
      ],
    );
  }
}



