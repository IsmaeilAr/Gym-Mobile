import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gym/components/widgets/snack_bar.dart';
import 'package:gym/features/authentication/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../features/authentication/screens/login_screen.dart';

class SessionExpiredInterceptor extends Interceptor {
  final BuildContext context;

  SessionExpiredInterceptor(this.context);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      debugPrint("401 is here");
      showMessage("Session Expired", false);
      doLogout(context);
    }
    super.onError(err, handler);
  }

  @override
  void onBadReq(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 400) {
      debugPrint("400 is here");
      showMessage(err.response?.data['data'], false);
      doLogout(context);
    }
    super.onError(err, handler);
  }

  doLogout(BuildContext context) {
    context
        .read<AuthProvider>()
        .callLogoutApi(context)
        .then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false,
            ));
  }
}
