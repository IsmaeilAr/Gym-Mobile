import 'package:flutter/material.dart';
import 'package:gym/components/widgets/snackBar.dart';
import 'package:gym/features/notifications/models/notification_model.dart';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gym/utils/helpers/api/api_helper.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationProvider extends ChangeNotifier {
  bool isDeviceConnected = false;

  bool _isLoadingNotifications = false;

  bool get isLoadingNotifications => _isLoadingNotifications;

  set isLoadingNotifications(bool value) {
    _isLoadingNotifications = value;
    notifyListeners();
  }

  List<NotificationModel> _notificationList = [];

  List<NotificationModel> get notificationList => _notificationList;

  set notificationList(List<NotificationModel> value) {
    _notificationList = value;
    notifyListeners();
  }

  Future<void> getNotifications(BuildContext context,) async {
    isLoadingNotifications = true;
    isDeviceConnected = await InternetConnectionChecker().hasConnection;

    if (isDeviceConnected) {
      try {
        Either<String, Response> results = await ApiHelper().getNotificationsApi();
        isLoadingNotifications = false;
        results.fold((l) {
          isLoadingNotifications = false;
           showMessage(l, false);
        }, (r) {
          Response response = r;
          if (response.statusCode == 200) {
            var data = response.data;
            log("data $data");
            List<dynamic> list = data;
            notificationList = list.map((e) => NotificationModel.fromJson(e)).toList();
            isLoadingNotifications = false;
          } else {
            isLoadingNotifications = false;
            log("## ${response.data}");
          }
        });
      } on Exception catch (e) {
        log("Exception get Notifications : $e");
         showMessage("$e", false);
        isLoadingNotifications = false;
      }
    } else {
      showMessage(AppLocalizations.of(context)!.noInternet, false);
      isLoadingNotifications = false;
    }
    notifyListeners();
  }


}