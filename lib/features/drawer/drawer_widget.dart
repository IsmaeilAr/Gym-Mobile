import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/components/widgets/gap.dart';
import 'package:gym/components/widgets/net_image.dart';
import 'package:gym/features/authentication/provider/auth_provider.dart';
import 'package:gym/features/authentication/screens/login_screen.dart';
import 'package:gym/features/main_layout/main_layout_provider.dart';
import 'package:gym/features/profile/provider/profile_provider.dart';
import 'package:gym/features/report/screens/report_screen.dart';
import 'package:gym/utils/localization/language_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../components/styles/gym_icons.dart';
import '../profile/models/user_model.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UserModel userProfile = context.watch<ProfileProvider>().profileInfo;
    // SharedPreferencesService prefsService = SharedPreferencesService.instance;
    // String userName = prefsService.getValue(Cache.userName) ?? "";
    // String userPhone = prefsService.getValue(Cache.userPhone) ?? "";
    // String userImage = prefsService.getValue(Cache.userImage) ?? "";

    return Drawer(
      backgroundColor: black,
      child: ListView(
        children: [
          DrawerHeader(
            margin: EdgeInsets.only(bottom: 8.h),
            padding: EdgeInsets.fromLTRB(14.w, 46.h, 16.w, 60.h),
            child: GestureDetector(
              onTap: () {
                context.read<MainLayoutProvider>().selectedIndex = 3;
                Scaffold.of(context).openEndDrawer();
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundImage: networkImage(userProfile),
                  ),
                  Gap(
                    w: 12.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userProfile.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: lightGrey,
                        ),
                      ),
                      Text(
                        userProfile.phoneNumber,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: lightGrey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const LanguageList(),
          ListTile(
            leading: Icon(
              GymIcons.report,
              color: lightGrey,
              size: 16.r,
            ),
            title: Text(
              AppLocalizations.of(context)!.drawerReportKey,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: lightGrey),
            ),
            onTap: (){
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      child: ReportScreen(
                      )));
            },
          ),
          ListTile(
            leading: Icon(
              GymIcons.logOut,
              color: lightGrey,
              size: 16.r,
            ),
            title: Text(
              AppLocalizations.of(context)!.drawerLogoutKey,
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
  context
      .read<AuthProvider>()
      .callLogoutApi(context)
      .then((value) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (Route<dynamic> route) => false,
          ));
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
    bool isEnglish =
        context.watch<LanguageProvider>().appLocale.languageCode == 'en';
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
            leading: Icon(
              GymIcons.language,
              color: lightGrey,
              size: 16.r,
            ),
            title: Text(
              AppLocalizations.of(context)!.drawerLanguageKey,
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
                    AppLocalizations.of(context)!.drawerLangCodeKey,
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
                    .changeLanguage(const Locale('ar', ''));
              },
              leading: Padding(
                padding: EdgeInsets.only(left: 37.w),
                child: !isEnglish
                    ? const SelectedLangIcon()
                    : const UnSelectedLangIcon(),
              ),
              title: Text(
                AppLocalizations.of(context)!.drawerArabicKey,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: !isEnglish ? grey : lightGrey),
              ),
            ),
          ),
          Visibility(
            visible: _showLanguage,
            child: ListTile(
              onTap: () {
                context
                    .read<LanguageProvider>()
                    .changeLanguage(const Locale('en', '')); // todo localize
              },
              leading: Padding(
                padding: EdgeInsets.only(left: 37.w),
                child: isEnglish
                    ? const SelectedLangIcon()
                    : const UnSelectedLangIcon(),
              ),
              title: Text(
                AppLocalizations.of(context)!.drawerEnglishKey,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: isEnglish ? grey : lightGrey),
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
      size: 15,
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
      color: grey,
      size: 15,
    );
  }
}