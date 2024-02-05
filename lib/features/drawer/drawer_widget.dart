

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/gap.dart';
import 'package:gym/features/authentication/provider/auth_provider.dart';
import 'package:gym/features/authentication/screens/login_screen.dart';
import 'package:gym/features/report/screens/report_screen.dart';
import 'package:gym/main.dart';
import 'package:gym/utils/helpers/cache.dart';
import 'package:gym/utils/localization/language_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SharedPreferencesService prefsService = SharedPreferencesService.instance;
    String userName = prefsService.getValue(Cache.userName) ?? "";
    String userPhone = prefsService.getValue(Cache.userPhone) ?? "";
    String userImage = prefsService.getValue(Cache.userImage) ?? "";

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
                  backgroundImage: NetworkImage(userImage),
                ),
                Gap(w: 12.w,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14.sp, color: lightGrey,),
                    ),
                    Text(
                      userPhone,
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
            onTap: (){
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: ReportScreen(
                      )));
            },
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
            onTap: (){
              doLogout(context);
            },
          ),
        ],
      ),
    );
  }
}

doLogout(BuildContext context) {
  context.read<AuthProvider>().callLogoutApi(context).then((value) => (value) ?
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false,)
      : null
  );
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
    bool isEnglish = LanguageProvider().appLocale.languageCode == 'en';
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
              onTap: () {
                context
                    .read<LanguageProvider>()
                    .changeLanguage(const Locale('en', ''));
              },
              leading: Padding(
                padding: EdgeInsets.only(left: 37.w),
                child: isEnglish
                    ? const SelectedLangIcon()
                    : const UnSelectedLangIcon(),
              ),
              title: Text('English', style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: grey),),
            ),
          ),
          Visibility(
            visible: _showLanguage,
            child: ListTile(
              onTap: () {
                context
                    .read<LanguageProvider>()
                    .changeLanguage(const Locale('ar', ''));
              },
              leading: Padding(
                padding: EdgeInsets.only(left: 37.w),
                child: !isEnglish
                    ? const SelectedLangIcon()
                    : const UnSelectedLangIcon(),
              ),
              title: Text(
                'Arabic',
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: lightGrey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UnSelectedLangIcon extends StatelessWidget {
  const UnSelectedLangIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.radio_button_off_outlined,
      color: lightGrey,
    );
  }
}

class SelectedLangIcon extends StatelessWidget {
  const SelectedLangIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.radio_button_checked_outlined,
      color: lightGrey,
    );
  }
}