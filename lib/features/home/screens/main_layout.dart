import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/gap.dart';
import 'package:gym/components/widgets/gym_traffic.dart';
import 'package:gym/components/widgets/icon_button.dart';
import 'package:gym/features/home/screens/home.dart';
import '../../programs/screens/programs_screen.dart';

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
    const ProgramScreen(),
    // const ProgressPage(),
    // const ProfilePage(),
  ];

  List<String> screenNames = [
    "Home",
    "Programs",
    "Progress",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: screenNames[_selectedIndex],
      ),

      body: Container(
          padding: EdgeInsets.all(14.w), child: screens[_selectedIndex]),
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

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: black,
      child: ListView(
        children: [
          DrawerHeader(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.fromLTRB(14.w, 46.h, 16.w, 60.h),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundImage: AssetImage("assets/images/profile.png"),
                ),
                Gap(w: 12.w,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Ismaeil",
                      style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14.sp, color: lightGrey,),
                    ),
                    Text(
                      "0988853928",
                      style: TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 12.sp, color: lightGrey,),
                    ),
                  ],
                )
              ],
            ),
          ),
          const LanguageList(),
          ListTile(
            leading: const Icon(
              Icons.report_gmailerrorred_rounded,
              color: lightGrey,
            ),
            title: Text(
              "Report",
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: lightGrey),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              color: lightGrey,
            ),
            title: Text(
              "Logout",
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: lightGrey),
            ),
          ),
        ],
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
          onPressed: () {},
        ),
        BarIconButton(
          icon: Icons.article_outlined,
          onPressed: () {},
        ),
        BarIconButton(
          icon: Icons.chat_outlined,
          onPressed: () {},
        ),
      ],
    );
  }
}


class LanguageList extends StatefulWidget {
  const LanguageList({super.key});


  @override
  State<LanguageList> createState() => _LanguageListState();
}

class _LanguageListState extends State<LanguageList> {
  bool _showLanguage = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            onTap: () {
              setState(() {
                _showLanguage = !_showLanguage;
              });
            },
            leading: const Icon(
              Icons.language_outlined,
              color: lightGrey,
            ),
            title: Text(
              "Language",
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: lightGrey),
            ),
            trailing: SizedBox(
              width: 35.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "EN",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                        color: grey),
                  ),
                  Icon(_showLanguage ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down_outlined,
                    color: grey,
                    size: 15.sp,)
                ],
              ),
            ),
          ),
          Visibility(
            visible: _showLanguage,
            child: ListTile(
              onTap: () {},
              leading: Padding(
                padding: EdgeInsets.only(left: 37.w),
                child: Icon(Icons.radio_button_checked_outlined, color: lightGrey,),
              ),
              title: Text('English', style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: grey),),
            ),
          ),
          Visibility(
            visible: _showLanguage,
            child: ListTile(
              onTap: () {},
              leading: Padding(
                padding: EdgeInsets.only(left: 37.w),
                child: Icon(Icons.radio_button_off_outlined, color: lightGrey,),
              ),
              title: Text('Arabic', style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: lightGrey),),
            ),
          ),
        ],
      ),
    );
  }
}
