import 'package:flutter/material.dart';
import 'package:gym/components/widgets/loading_indicator.dart';
import 'package:gym/features/authentication/screens/login_screen.dart';
import 'package:gym/features/main_layout/main_layout.dart';
import 'package:gym/features/profile/provider/profile_provider.dart';
import 'package:gym/utils/helpers/api/api_helper.dart';
import 'package:gym/utils/helpers/cache.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SplashScreen extends StatefulWidget {
  final WebSocketChannel channel;

  const SplashScreen({super.key, required this.channel});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// Import for Timer class

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    initData();
    ApiHelper.setupInterceptors(context);
    super.initState();
  }

  void initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(Cache.token) ?? "";
    bool isAuth = prefs.getBool(Cache.isAuth) ?? false;
    // todo isFirst login then give it to login maybe ??
    if (isAuth && token.isNotEmpty) {
      // Check if the token is expired
      bool isTokenExpired = isExpired(token);

      if (!isTokenExpired) {
        // Token is not expired, navigate to main layout
        navigateToMainLayout();
      } else {
        // Token is expired, navigate to login screen
        navigateToLoginPage();
      }
    } else {
      navigateToLoginPage();
    }

    // Set loading indicator to false once initialization is complete
    setState(() {
      _isLoading = false;
    });
  }

  bool isExpired(String token) {
    bool hasExpired = JwtDecoder.isExpired(token);
    return hasExpired;
  }

  void navigateToMainLayout() {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeftWithFade,
        child: MainLayout(),
      ),
    );
    context.read<ProfileProvider>().getProfileInfo(context);
  }

  void navigateToLoginPage() {
    Navigator.pushReplacement(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeftWithFade,
        child: LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const LoadingIndicatorWidget() // Show loading indicator if still loading
            : const SizedBox(), // Otherwise, show nothing
      ),
    );
  }
}
