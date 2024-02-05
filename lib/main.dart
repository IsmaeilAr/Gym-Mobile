import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gym/utils/localization/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:gym/features/articles/provider/article_provider.dart';
import 'package:gym/features/authentication/provider/auth_provider.dart';
import 'package:gym/features/chat/provider/chat_provider.dart';
import 'package:gym/features/coaches/provider/coach_provider.dart';
import 'package:gym/features/home/provider/home_provider.dart';
import 'package:gym/features/notifications/provider/notification_provider.dart';
import 'package:gym/features/profile/provider/profile_provider.dart';
import 'package:gym/features/programs/provider/program_provider.dart';
import 'package:gym/features/progress/provider/progress_provider.dart';
import 'package:gym/features/report/provider/report_provider.dart';
import 'package:gym/features/authentication/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
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
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, _) {
          return MaterialApp(
            title: 'Gym',
            locale: languageProvider.appLocale,
            supportedLocales: const [
              Locale('en', ''),
              Locale('ar', ''),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(
                // Define your theme here
                // colorScheme: darkThemeColors,
                // scaffoldBackgroundColor: black,
                // fontFamily: 'Saira',
                // useMaterial3: true,
                ),
            home: const LoginScreen(),
          );
        },
      ),
    );
  }
}
