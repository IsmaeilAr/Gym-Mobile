import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/components/widgets/snack_bar.dart';
import 'package:gym/features/authentication/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SessionExpiredInterceptor extends Interceptor {
  final BuildContext context;

  SessionExpiredInterceptor(this.context);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // if (err.response?.statusCode == 401) {
    if (err.response?.statusCode == 401) {
      debugPrint("401 is here");
      showMessage("Session Expired", false);
      context.read<AuthProvider>().callLogoutApi(context);
      // Session expired, navigate to login screen
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => const LoginScreen()),
      //   (Route<dynamic> route) => false,
      // );
    }
    super.onError(err, handler);
  }
}
