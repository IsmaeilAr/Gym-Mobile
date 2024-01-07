import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/gap.dart';
import 'package:gym/components/widgets/gym_traffic.dart';
import 'package:gym/components/widgets/icon_button.dart';
import 'package:gym/features/home/screens/home.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final pageIconList = <IconData>[
    Icons.home_filled,
    Icons.paste_outlined,
    Icons.query_stats_outlined,
    Icons.person,
  ];

  List<Widget> screens = [
    const HomePage(),
    const CategoriesPage(),
    const CartPage(),
    const FavoritesPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      bottomNavigationBar: GNav(
        gap: 20.w,
        // tabMargin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 30.w),
        backgroundColor: black,
        rippleColor: lightGrey,
        hoverColor: Colors.redAccent,
        activeColor: red,
        tabBackgroundColor: black,
        // color: black,
        iconSize: 24.h,
        padding:
        EdgeInsets.symmetric(horizontal: 50.w, vertical: 12.h),
        duration: const Duration(milliseconds: 400),
        tabs: [
          GButton(
            icon: Icons.home_filled,
            iconSize: 25.h,
            iconColor: grey,
          ),
          GButton(
            icon: ModaLife.cate_filled,
            iconSize: 20.h,
            iconColor: grey,
          ),
          GButton(
            icon: ModaLife.bag_big_white,
            iconSize: 30.h,
            iconColor: grey,
          ),
          GButton(
            icon: ModaLife.fav_outlined,
            iconSize: 25.h,
            icon: Icons.favorite_outline,
          ),
          GButton(
            icon: ModaLife.profile,
            iconSize: 20.h,
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          context.read<BottomNavBarProvider>().currentIndex = index;
          // setState(() {
          //   _selectedIndex = index;
          // });
        },
      ),
      body: Container(
          padding: EdgeInsets.all(14.w),
          child: HomePage()),
    );
  }
}

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: black,
      leading: BarIconButton(icon: Icons.menu, onPressed: (){},),
      title: Text("Home", style: TextStyle(color: lightGrey, fontSize: 20.sp, fontWeight: FontWeight.w700),),
      actions: [
        BarIconButton(icon: Icons.notifications_none_outlined, onPressed: (){},),
        BarIconButton(icon: Icons.article_outlined, onPressed: (){},),
        BarIconButton(icon: Icons.chat_outlined, onPressed: (){},),
      ],
    );
  }
}
