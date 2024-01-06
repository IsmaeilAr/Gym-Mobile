import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/gap.dart';
import 'package:gym/components/widgets/gym_traffic.dart';
import 'package:gym/components/widgets/icon_button.dart';
import 'package:gym/home/screens/home.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        leading: BarIconButton(icon: Icons.menu, onPressed: (){},),
        title: Text("Home", style: TextStyle(color: lightGrey, fontSize: 20.sp, fontWeight: FontWeight.w700),),
        actions: [
          BarIconButton(icon: Icons.notifications_none_outlined, onPressed: (){},),
          BarIconButton(icon: Icons.article_outlined, onPressed: (){},),
          BarIconButton(icon: Icons.chat_outlined, onPressed: (){},),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(items: items),
      body: Container(
          padding: EdgeInsets.all(14.w),
          child: HomePage()),
    );
  }
}
