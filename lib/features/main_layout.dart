import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/icon_button.dart';
import 'package:gym/features/chat/screens/chat_list_screen.dart';
import 'package:gym/features/drawer/drawer_widget.dart';
import 'package:gym/features/home/screens/home.dart';
import 'package:gym/features/notifications/screens/notifications_screen.dart';
import 'package:gym/features/profile/screens/my_profile.dart';
import 'package:gym/features/progress/screens/progress_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'articles/screens/articles_screen.dart';
import 'programs/screens/programs_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final pageIconList = <IconData>[
    Icons.home_filled,
    Icons.paste_outlined,
    Icons.query_stats_outlined,
    Icons.person,
  ];

  final screens = <Widget>[
    const HomePage(),
    const ProgramsScreen(),
    const ProgressScreen(),
    const MyProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    List<String> screenNames = [
      AppLocalizations.of(context)!.mainLayoutAppBarHomeScreenName,
      AppLocalizations.of(context)!.mainLayoutAppBarProgramsScreenName,
      AppLocalizations.of(context)!.mainLayoutAppBarProgressScreenName,
      AppLocalizations.of(context)!.mainLayoutAppBarProfileScreenName,
    ];
    return Scaffold(
      appBar: MainAppBar(
        title: screenNames[_selectedIndex],
      ),
      body: Container(
          // padding: EdgeInsets.all(14.w),
          child: screens[_selectedIndex]),
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
            ),
            GButton(
              icon: pageIconList[3],
              iconColor: grey,
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
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
          icon: Icons.notifications_none_outlined,
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const NotificationsScreen(
                    )
                ));
          },
        ),
        BarIconButton(
          icon: Icons.article_outlined,
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const ArticlesScreens(
                    )
                ));
          },
        ),
        BarIconButton(
          icon: Icons.chat_outlined,
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: const ChatListScreen(
                    )
                ));
          },
        ),
      ],
    );
  }
}


