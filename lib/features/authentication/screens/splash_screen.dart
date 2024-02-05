// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
//
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   VideoPlayerController vidCont =
//       VideoPlayerController.asset('assets/splash.mp4');
//   late ChewieController cont;
//
//   void initData() async {
//     late bool isLogged;
//     String token = prefsService.getValue(Cache.token) ?? "";
//     bool isAuth = prefs.getBool(Cache.isAuth) ?? false;
//     if (isAuth) {
//       // if isAuth is true
//       if (token.isEmpty) {
//         // isAuth is true & if token is empty
//         Navigator.pushReplacement(
//             context,
//             PageTransition(
//                 type: PageTransitionType.fade, child: const LoginPage()));
//       } else {
//         // isAuth is true & token is there
//         Navigator.pushReplacement(
//             context,
//             PageTransition(
//                 type: PageTransitionType.fade, child: const MainLayout()));
//       }
//     } else {
//       // if isAuth is false
//       Navigator.pushReplacement(
//           context,
//           PageTransition(
//               type: PageTransitionType.fade, child: const LoginPage()));
//     }
//   }
//
//   @override
//   void initState() {
//     cont = ChewieController(
//         videoPlayerController: vidCont,
//         looping: false,
//         aspectRatio: ScreenUtil().screenWidth / ScreenUtil().screenHeight,
//         autoPlay: true,
//         showControls: false);
//     super.initState();
//     Future.delayed(const Duration(seconds: 3), () async {
//       // added below 3 lines to record app language // added async
//       final currentLocale  = Localizations.localeOf(context);
//       final String currentLanguage = currentLocale.languageCode;
//       appLanguage = currentLanguage;
//       // await prefsService.setValue(Cache.appLanguage, currentLanguage);
//       initData();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SizedBox(
//       height: ScreenUtil().screenHeight,
//       width: ScreenUtil().screenWidth,
//       child: Chewie(
//         controller: cont,
//       ),
//     ));
//   }
// }
