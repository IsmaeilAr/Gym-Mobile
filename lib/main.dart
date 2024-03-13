import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym/components/styles/colors.dart';
import 'package:gym/features/articles/provider/article_provider.dart';
import 'package:gym/features/authentication/provider/auth_provider.dart';
import 'package:gym/features/authentication/screens/splash_screen.dart';
import 'package:gym/features/chat/provider/chat_provider.dart';
import 'package:gym/features/coaches/provider/coach_provider.dart';
import 'package:gym/features/home/provider/home_provider.dart';
import 'package:gym/features/notifications/provider/notification_provider.dart';
import 'package:gym/features/profile/provider/profile_provider.dart';
import 'package:gym/features/programs/provider/program_provider.dart';
import 'package:gym/features/progress/provider/progress_provider.dart';
import 'package:gym/features/report/provider/report_provider.dart';
import 'package:gym/test.dart';
import 'package:gym/test_2.dart';
import 'package:gym/utils/helpers/cache.dart';
import 'package:gym/utils/localization/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:web_socket_channel/io.dart';
import 'features/main_layout/main_layout_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initSharedPreferences();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ArticleProvider()),
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => ChatProvider()),
    ChangeNotifierProvider(create: (_) => CoachProvider()),
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => NotificationProvider()),
    ChangeNotifierProvider(create: (_) => ProfileProvider()),
    ChangeNotifierProvider(create: (_) => ProgramProvider()),
    ChangeNotifierProvider(create: (_) => ProgressProvider()),
    ChangeNotifierProvider(create: (_) => ReportProvider()),
    ChangeNotifierProvider(create: (_) => LanguageProvider()),
    ChangeNotifierProvider(create: (_) => MainLayoutProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gym',
        locale: languageProvider.appLocale,
        supportedLocales: const [
          Locale('en', ''),
          Locale('ar', ''),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
          // colorScheme: darkThemeColors, // need to extract flutter widget...
          scaffoldBackgroundColor: black,
          fontFamily: 'Saira',
          useMaterial3: true,
        ),
        home: SplashScreen(
          channel: IOWebSocketChannel.connect(
            "ws://echo.websocket.org",
          ),
        ),
        // home: const Tester(),
      ),
    );
  }
}
