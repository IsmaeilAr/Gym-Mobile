import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/features/authentication/screens/login_screen.dart';

class SessionExpiredInterceptor extends Interceptor {
  final BuildContext context;

  SessionExpiredInterceptor(this.context);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // Session expired, navigate to login screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }
    super.onError(err, handler);
  }
}
